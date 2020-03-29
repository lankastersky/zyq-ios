import UIKit

/// UIViewController Utils.
extension UIViewController {
    var appDelegate: AppDelegate {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)!
        }
        set {}
    }

    var exerciseService: ExerciseService {
        get {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                assertionFailure("Failed to get app delegate")
                return ExerciseService()
            }
            return appDelegate.exerciseService
        }
        set {}
    }

}
