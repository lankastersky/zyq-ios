import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet var imageTopConstraint: NSLayoutConstraint!
    
    var exercise: Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = exercise?.name

        descriptionLabel.attributedText = exercise?.description.htmlAttributedString()
        showImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //showImage()
    }

    private func showImage() {
        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return
        }
        guard let imageName = exercise?.imageName else {
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
}
