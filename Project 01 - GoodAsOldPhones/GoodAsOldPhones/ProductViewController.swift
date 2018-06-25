//
//  ViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: - Data
    
    var product: Product? {
        didSet {
            if let product = product {
                productNameLabel.text = product.name
                productImageView.image = UIImage(named: product.largeImageName)
            }
        }
    }
    
    // MARK: - Views
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "button-addtocart"), for: .normal)
        
        return button
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    // MARK: - Private helpers
    
    private func setUpViews() {
        // add views to view hierarchy
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(addToCartButton)
        
        // constraint views
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        if #available(iOS 11.0, *) {
            let safeArea = view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                productNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40)
                ])
            
            NSLayoutConstraint.activate([
                productImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                productImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
        } else {
            NSLayoutConstraint.activate([
                productNameLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20)
                ])
            
            NSLayoutConstraint.activate([
                productImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                productImageView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)])
        }
        
        NSLayoutConstraint.activate([
            addToCartButton.widthAnchor.constraint(equalToConstant: 140),
            addToCartButton.heightAnchor.constraint(equalToConstant: 60),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 40)])
        
        // setup button
        addToCartButton.addTarget(self, action: #selector(ProductViewController.addToCartButtonDidTap), for: .touchUpInside)
    }
    
    @objc func addToCartButtonDidTap() {
        print("Add to cart successfully")
    }
}
