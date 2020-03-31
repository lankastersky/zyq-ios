import UIKit

class ExerciseViewController: ZyqViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet var imageTopConstraint: NSLayoutConstraint!
    
    var exercise: Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = exercise?.name

        descriptionLabel.attributedText = exercise?.description.htmlAttributedString()
        showImage()

        guard let ex = exercise else {
            assertionFailure("exercises is not initialized")
            return
        }
        descriptionUrl = exerciseService.getPracticeDescription(
            level: ex.level, type: ex.type, name: ex.id)

        initBarItems()
    }

    override func initBarItems() {
        super.initBarItems()
        if (exercise!.videoUrl.isEmpty) {
            return
        }
        let helpButton = UIBarButtonItem(
            image: UIImage(named: "video_icon")?.withRenderingMode(.alwaysOriginal),
        style: .plain, target: self, action: #selector(showVideo))
        navigationItem.rightBarButtonItems?.append(helpButton)
    }

    private func showImage() {
        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return
        }
        guard let imageName = exercise?.imageName else {
            assertionFailure("Failed to get image name")
            return
        }
        if imageName.isEmpty {
            imageTopConstraint.isActive = false
            imageView.isHidden = true
            return
        }
        if let image = UIImage(contentsOfFile: resourcePath + "/images/" + imageName) {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        }
    }

    @objc func showVideo() {
        ExerciseViewController.openUrl(exercise!.videoUrl)
    }

    private static func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            assertionFailure("Failed to parse url")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
