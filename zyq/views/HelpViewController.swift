import MessageUI
import UIKit

/// Shows help screen
final class HelpViewController: WebViewController {

    override func loadView() {
        super.loadView()
        titleString = "help_screen_title".localized
        let fileName = Utils.isRu() ? "help.html" : "help_en.html"
        url = exerciseService.getAssetsUrl(fileName: fileName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let feedbackButton = UIBarButtonItem(
            image: UIImage(named: "feedback_icon")?.withRenderingMode(.alwaysOriginal),
        style: .plain, target: self, action: #selector(sendFeedback))
        navigationItem.rightBarButtonItem = feedbackButton

//        versionLabel.text =
//            String.localizedStringWithFormat("help_screen_version".localized, Utils.versionNumber)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setupTitleFontAppearance()
        self.navigationController?.navigationBar.setupTitleColorAppearance(UIColor.darkSkinColor)
    }

    @objc private func sendFeedback(sender: UIButton!) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["lankastersky@gmail.com"])
            let subject =
                "\(Utils.appName) iOS feedback \(Utils.versionNumber) (\(Utils.buildNumber))"
            mail.setSubject(subject)
            mail.setMessageBody("", isHTML: true)

            present(mail, animated: true)
        } else {
            print("Failed to send email")
            let alert = Utils.buildAlert("help_screen_send_feedback_alert_title".localized,
                             "help_screen_send_feedback_alert_text".localized)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension HelpViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true)

        if let error = error {
            print("Failed to compose email:\(error)")
        }
    }
}
