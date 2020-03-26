import UIKit

/// Shows Stage screen
class StageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak private var tableHeightConstraint: NSLayoutConstraint!

    private var exercises: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(nibName: "StageTableViewCell", bundle: nil),
            forCellReuseIdentifier: StageTableViewCell.stageViewCellReuseIdentifier)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let tabBarController = self.appDelegate.window?.rootViewController as? UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }

        let stage = tabBarController.selectedIndex;
        switch(stage) {
        case NavigationTab.stage1.rawValue:
            navigationItem.title = "stage1_screen_title".localized
            exercises = [String](repeating: "1", count: 8)
            break
        case NavigationTab.stage2.rawValue:
            navigationItem.title = "stage2_screen_title".localized
            exercises = [String](repeating: "2", count: 12)
            break
        case NavigationTab.stage3.rawValue:
            navigationItem.title = "stage3_screen_title".localized
            break
        default:
            break
        }

        // TODO: fix height
        tableView.reloadData()
        //tableHeightConstraint.constant = tableView.contentSize.height
        tableView.layoutIfNeeded()
//        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true

    }
}


extension StageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StageTableViewCell.stageViewCellReuseIdentifier)
            as? StageTableViewCell else {
                assertionFailure("Failed to get stage cell")
                return UITableViewCell()
        }
        cell.nameLabel.text = exercises[indexPath.row];
        return cell
    }
}
