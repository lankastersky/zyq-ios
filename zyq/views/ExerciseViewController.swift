import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!

    var exercise: Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = exercise?.name

        descriptionLabel.attributedText = exercise?.description.htmlAttributedString()

        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return
        }
        guard let imageName = exercise?.imageName else {
            return
        }
        if imageName.isEmpty {
            return
        }
        if let image = UIImage(contentsOfFile: resourcePath + "/images/" + imageName) {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        }
    }
}
