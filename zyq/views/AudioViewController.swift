import UIKit
import AVFoundation

/// Plays audio.
class AudioViewController: ListViewController {

    private let audioNames: [String : String] = [
        "song_3_Feng_Shui_60".localized : "http://www.qigong.ru/music/3_Feng_Shui_60.mp3",
        "song_4_Garmonic_72".localized : "http://www.qigong.ru/music/4_Garmonic_72.mp3",
        "song_5_Gong_Yi_63".localized : "http://www.qigong.ru/music/5_Gong_Yi_63.mp3",
        "song_2_Himalaya_50".localized : "http://www.qigong.ru/music/2_Himalaya_50.mp3",
        "song_8_Tai_Chi_61".localized : "http://www.qigong.ru/music/8_Tai_Chi_61.mp3",
        "song_6_Tibetian_Bowls_66".localized : "http://www.qigong.ru/music/6_Tibetian_Bowls_66.mp3",
        "song_7_Big_Tree_44".localized : "http://www.qigong.ru/music/7_Big_Tree_44.mp3",
        "song_1_Yan_Qi_73".localized : "http://www.qigong.ru/music/1_Yan_Qi_73.mp3"
    ]

    private var player : AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?
    // Key-value observing context
    private var playerItemContext = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "audio_screen_title".localized
        initBarItems()
        self.listView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setupTitleFontAppearance()
        self.navigationController?.navigationBar.setupTitleColorAppearance(UIColor.darkSkinColor)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = self.listView.indexPathsForSelectedItems?.first ??
            IndexPath(item: 0, section: 0)
        self.listView.selectItem(at: indexPath, animated: false, scrollPosition:
            UICollectionView.ScrollPosition.centeredHorizontally)
        self.collectionView(self.listView, didSelectItemAt: indexPath)
    }

    override func initBarItems() {
        onPause()
    }

    @objc func onPlay() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.pause, target: self, action: #selector(onPause))

        let indexPath = self.listView.indexPathsForSelectedItems?.first ??
            IndexPath(item: 0, section: 0)
        playAudio(indexPath: indexPath)
    }

    @objc func onPause() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.play, target: self, action: #selector(onPlay))
        pauseAudio()
    }

    // MARK: UICollectionViewDataSource

    override func initCell(cell: CollectionViewCell, indexPath: IndexPath) {
        cell.nameLabel.text = Array(audioNames)[indexPath.item].key
        cell.showType(false)
    }

    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.collectionCellReuseIdentifier,
            for: indexPath
        ) as? CollectionViewCell else {
            print("Failed to instantiate cell")
            return UICollectionViewCell()
        }

        assert(indexPath.item < audioNames.count,
               "Bad index when creating collection view")

        initCell(cell: cell, indexPath: indexPath)

        cell.widthConstraint.constant = collectionView.frame.size.width - 2.0 * leftRightMargin
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return audioNames.count
    }

    private func pauseAudio() {
        player?.pause()
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }

    private func playAudio(indexPath: IndexPath) {
        let audioName = Array(audioNames)[indexPath.item].value
        guard let url = URL.init(string: audioName) else {
            return
        }
        if let asset = self.player?.currentItem?.asset {
            if let urlAsset = asset as? AVURLAsset {
                if urlAsset.url.absoluteString == audioName {
                    player?.play()
                    return
                }
            }
        }
        if player?.timeControlStatus == .playing {
            removePeriodicTimeObserver()
            player?.removeAllItems()
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }

        player = AVQueuePlayer()
        let playerItem = AVPlayerItem.init(url: url)

        // Register as an observer of the player item's status property
//        playerItem.addObserver(self,
//                               forKeyPath: #keyPath(AVPlayerItem.status),
//                               options: [.old, .new],
//                               context: &playerItemContext)

        playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)

        self.player?.insert(playerItem, after: nil)
        self.player?.play()
        addPeriodicTimeObserver()

        indicator?.startAnimating()
    }

//    override func observeValue(forKeyPath keyPath: String?,
//                               of object: Any?,
//                               change: [NSKeyValueChangeKey : Any]?,
//                               context: UnsafeMutableRawPointer?) {
//
//        // Only handle observations for the playerItemContext
//        guard context == &playerItemContext else {
//            super.observeValue(forKeyPath: keyPath,
//                               of: object,
//                               change: change,
//                               context: context)
//            return
//        }
//
//        if keyPath == #keyPath(AVPlayerItem.status) {
//            let status: AVPlayerItem.Status
//            if let statusNumber = change?[.newKey] as? NSNumber {
//                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
//            } else {
//                status = .unknown
//            }
//
//            // Switch over status value
//            switch status {
//            case .readyToPlay: break
//                // Player item is ready to play.
//            case .failed: break
//                // Player item failed. See error.
//            case .unknown: break
//                // Player item is not yet ready.
//            @unknown default:
//                fatalError()
//            }
//        }
//    }

    var timeObserverToken: Any?

    func addPeriodicTimeObserver() {
        // Invoke callback every half second
        let interval = CMTime(seconds: 0.5,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        // Add time observer. Invoke closure on the main queue.
        timeObserverToken =
            player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
                [weak self] time in
                // update player transport UI
//                if let currentItem = self?.player?.currentItem {
//                    let duration = currentItem.asset.duration
//                    if time == duration {
//                        self?.player?.seek(to: CMTime.zero)
//                    }
//                }
                if time == CMTime.zero && self?.player?.timeControlStatus == .playing {
                    self?.indicator?.stopAnimating()
                    self?.removePeriodicTimeObserver()
                }
        }
    }
    func removePeriodicTimeObserver() {
        // If a time observer exists, remove it
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
}
