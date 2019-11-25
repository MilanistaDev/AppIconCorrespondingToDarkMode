//
//  ViewController.swift
//  AppIconCorrespondingToDarkMode
//
//  Created by Takuya Aso on 2019/11/25.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // ダークモード用のアプリを設定する
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    UIApplication.shared.setAlternateIconName("AppIcon-Dark") { error in
                        if let error = error {
                            self.errorLabel.text = error.localizedDescription
                        }
                    }
                }
            } else {
                // nilをセットしデフォルトのアプリアイコン画像に変更
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    UIApplication.shared.setAlternateIconName(nil) { error in
                        if let error = error {
                            self.errorLabel.text = error.localizedDescription
                        }
                    }
                }
            }
        }
    }
}
