//
//  SettingsViewController.swift
//  AppIconCorrespondingToDarkMode
//
//  Created by Takuya Aso on 2019/11/25.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import UIKit

/// Almost messy code
final class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellName = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    private func setUpUI() {
        self.navigationItem.title = "Settings"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    /// Match the App Icon to the current Appearance
    private func matchAppIcon() {
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // ダークモード用のアプリを設定する
                UIApplication.shared.setAlternateIconName("AppIcon-Dark") { error in
                    if let error = error {
                        self.showAlert(errorText: error.localizedDescription)
                    }
                }
            } else {
                // nilをセットしデフォルトのアプリアイコン画像に変更
                UIApplication.shared.setAlternateIconName(nil) { error in
                    if let error = error {
                        self.showAlert(errorText: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showAlert(errorText: String) {
        let alert = UIAlertController(title: "Error",
                                      message: errorText,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {
            self.matchAppIcon()
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellName, for: indexPath)
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "Settings"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.text = "App Icon"
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = "App Version"
            cell.detailTextLabel?.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "APP SETTINGS" : "APP VERSION"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? "Match the App icon to the current appearance." : ""
    }
}
