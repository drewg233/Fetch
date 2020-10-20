//
//  UIViewController+PresentAlert.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import UIKit

public extension UIViewController {
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            alertController.addAction(action)
        }

        if actions.count == 0 {
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK alert button action."), style: .default)
            alertController.addAction(okAction)
        }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
