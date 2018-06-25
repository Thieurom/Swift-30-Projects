//
//  ContactView.swift
//  GoodAsOldPhones
//
//  Created by Doan Le Thieu on 6/25/18.
//  Copyright © 2018 Code School. All rights reserved.
//

import UIKit

class ContactView: UIScrollView {
    
    private lazy var contentView: UIStackView = {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .fill
        contentView.distribution = .fill
        contentView.spacing = 0
        
        return contentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
    private func initView() {
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
//        if #available(iOS 11.0, *) {
//            contentLayoutGuide.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor).isActive = true
//        }
        
        // header image view
        let headerImageView = UIImageView(image: UIImage(named: "header-contact"))
        headerImageView.contentMode = .scaleToFill
        contentView.addArrangedSubview(headerImageView)
        
        // body view
        let bodyView = UIView()
        contentView.addArrangedSubview(bodyView)
        
        // body container view
        let bodyContainerView = UIStackView()
        bodyContainerView.axis = .vertical
        bodyContainerView.alignment = .fill
        bodyContainerView.distribution = .fill
        bodyContainerView.spacing = 40
        bodyView.addSubview(bodyContainerView)
        
        bodyContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyContainerView.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 60),
            bodyContainerView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 60),
            bodyContainerView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -60),
            bodyContainerView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -30)])

        // about view
        let aboutStackView = makeBodyItemStackView(title: "About Us")
        bodyContainerView.addArrangedSubview(aboutStackView)
        
        let aboutBodyLabel1 = UILabel()
        aboutBodyLabel1.numberOfLines = 0
        aboutBodyLabel1.text = "Good as Old Phones returns the phones of  yesteryear back to their original glory and then gets them into the hands* of those who appreciate them most:"
        aboutStackView.addArrangedSubview(aboutBodyLabel1)
        
        let aboutBodyLabel2 = UILabel()
        aboutBodyLabel2.numberOfLines = 0
        aboutBodyLabel2.text = "Whether you are looking for a turn-of-the-century wall set or a Zack Morris Special, we've got you covered. Give us a ring, and we will get you connected."
        aboutStackView.addArrangedSubview(aboutBodyLabel2)
        
        let aboutBodyLabel3 = UILabel()
        aboutBodyLabel3.font = UIFont.italicSystemFont(ofSize: 15)
        aboutBodyLabel3.text = "*Hands-free phones available"
        aboutStackView.addArrangedSubview(aboutBodyLabel3)
        
        // contact view
        let contactStackView = makeBodyItemStackView(title: "Contact")
        bodyContainerView.addArrangedSubview(contactStackView)
        
        let emailContactView = makeContactItemStackView(title: "good-as-old@example.com", imageName: "icon-about-email")
        let phoneContactView = makeContactItemStackView(title: "412-888-9028", imageName: "icon-about-phone")
        let webContactView = makeContactItemStackView(title: "www.example.com", imageName: "icon-about-website")
        contactStackView.addArrangedSubview(emailContactView)
        contactStackView.addArrangedSubview(phoneContactView)
        contactStackView.addArrangedSubview(webContactView)
    }
    
    private func makeBodyItemStackView(title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 40
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.text = title
        stackView.addArrangedSubview(titleLabel)
        
        return stackView
    }
    
    private func makeContactItemStackView(title: String, imageName: String) -> UIStackView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let contactItemView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        contactItemView.axis = .horizontal
        contactItemView.alignment = .fill
        contactItemView.distribution = .fill
        contactItemView.spacing = 30
        
        return contactItemView
    }
}
