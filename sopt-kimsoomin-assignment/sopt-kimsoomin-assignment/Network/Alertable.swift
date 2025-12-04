//
//  Alertable.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import UIKit

public protocol Alertable: AnyObject {
    func showAlert(title: String, message: String, completion: (() -> Void)?)
}

public extension Alertable where Self: UIViewController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        self.present(alert, animated: true)
    }
}
