import UIKit

/// Shows exercises.
/// May be it's better to use tableview instead but I couldn't make it work with adjusted height.
class ListViewController: ZyqViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let leftRightMargin: CGFloat = 12.0

    weak var listView: UICollectionView!
    var level: LevelType = .unknown
    var exercises: [ExerciseGroup] = []

    override func loadView() {
        super.loadView()

        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.listView = collectionView
        self.listView.dataSource = self
        self.listView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.listView.alwaysBounceVertical = true
        self.listView.backgroundColor = .white

        listView?.register(
            UINib(nibName: "CollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CollectionViewCell.collectionCellReuseIdentifier
        )
        
        // See https://goo.gl/yAUR1R
        if let flowLayout = listView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance(level: level)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return exercises.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.collectionCellReuseIdentifier,
            for: indexPath
        ) as? CollectionViewCell else {
            print("Failed to instantiate cell")
            return UICollectionViewCell()
        }

        assert(indexPath.item < exercises.count,
               "Bad index when creating collection view")

        initCell(cell: cell, indexPath: indexPath)

        cell.widthConstraint.constant = collectionView.frame.size.width - 2.0 * leftRightMargin
        return cell
    }

    func initCell(cell: CollectionViewCell, indexPath: IndexPath) {
        let ex: ExerciseGroup = exercises[indexPath.item] as ExerciseGroup
        cell.nameLabel.text = ex.name
        cell.showType(false)
        cell.applyShadows()
    }
    
    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            cell.contentView.backgroundColor = UIColor.white
        }
    }
}
