//
//  BaseViewController.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import UIKit

open class BaseViewController: UIViewController, Alertable, LoadingIndicatorable {
    
    // MARK: - UI Components
    
    public let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - LifeCycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseUI()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.bringSubviewToFront(loadingIndicator)
    }
    
    // MARK: - UI Setup
    
    open func setBaseUI() {
        view.backgroundColor = .white
        
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Methods
    
    @objc
    open func dismissKeyboard() {
        view.endEditing(true)
    }
}
