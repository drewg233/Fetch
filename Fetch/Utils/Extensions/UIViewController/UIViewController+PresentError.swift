//
//  UIViewController+PresentError.swift
//  Fetch
//
//  Created by Andrew Garcia on 10/20/20.
//

import UIKit

protocol ErrorPresenter {
    func presentError(_ error: Error, actions: [UIAlertAction])
}

extension ErrorPresenter where Self: UIViewController {
    func presentError(_ error: Error, actions: [UIAlertAction] = []) {
        self.presentAlert(title: error.localizedDescription, message: (error as NSError).localizedRecoverySuggestion, actions: actions)
    }

    func presentError(_ error: Error, completion: @escaping() -> ()) {
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK alert button action."), style: .default) { (_) in
            completion()
        }

        self.presentError(error, actions: [okAction])
    }
}
