//
//  LoadingIndicatorable.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import UIKit

public protocol LoadingIndicatorable: AnyObject {
    var loadingIndicator: UIActivityIndicatorView { get }
}

// MARK: - Default Implementation (기본 구현)

public extension LoadingIndicatorable where Self: UIViewController {
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}

