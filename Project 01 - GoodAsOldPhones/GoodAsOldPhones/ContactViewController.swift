//
//  ContactViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    // MARK: - Views
    
    lazy var contactView: ContactView = {
        let view = ContactView()
        
        return view
    }()
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "Us"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    // MARK: - Private helpers
    
    private func setUpView() {
        view.addSubview(contactView)
        
        contactView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactView.topAnchor.constraint(equalTo: view.topAnchor),
            contactView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contactView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
