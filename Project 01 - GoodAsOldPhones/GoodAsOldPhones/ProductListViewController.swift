//
//  ProductListViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Data
    
    var products: [Product]!
    private let cellIdentifer = "ProductCell"
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        
        return tableView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
    
    // MARK: - Private helpers
    
    private func setUpViews() {
        // title
        title = "Products"
        navigationItem.title = nil
        
        // add to view hierarchy and constraint
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        // setup table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 94
    }
    
    private func loadProducts() {
        products = [
            Product(name: "1907 Wall Set", thumbnailImageName: "image-cell1", largeImageName: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", thumbnailImageName: "image-cell2", largeImageName: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", thumbnailImageName: "image-cell3", largeImageName: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", thumbnailImageName: "image-cell4", largeImageName: "phone-fullscreen4")]
    }
    
    private func config(cell: UITableViewCell, at indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = product.name
        cell.imageView?.image = UIImage(named: product.thumbnailImageName)
    }
    
    // MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
       
        config(cell: cell, at: indexPath)
        
        return cell;
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        let productViewController = ProductViewController()
        productViewController.product = product
        
        navigationController?.pushViewController(productViewController, animated: true)
    }
}
