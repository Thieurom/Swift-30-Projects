/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ArtistListViewController: UIViewController {
    
    let artists = Artist.artistsFromBundle()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - View Life cycle
    
    override func viewWillLayoutSubviews() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    // MARK: - Private
    
    private func configView() {
        // navigation bar
        navigationItem.title = "Artistry"
        
        // table view
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    private func configCell(_ cell: ArtistTableViewCell, with artist: Artist) {
        cell.bioLabel.text = artist.bio
        cell.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
        cell.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        cell.artistImageView.image = artist.image
        
        cell.nameLabel.text = artist.name
        cell.nameLabel.textColor = UIColor.white
        cell.nameLabel.textAlignment = .center
        cell.nameLabel.backgroundColor = UIColor(red: 1, green: 152 / 255, blue: 0, alpha: 1)
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}

// MARK: - UITableView Data Source

extension ArtistListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell", for: indexPath) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        let artist = artists[indexPath.row]
        configCell(cell, with: artist)
        
        return cell
    }
}

// MARK: - UITableView Delegate

extension ArtistListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        let artistDetailViewController = ArtistDetailViewController(artist: artist)
        navigationController?.pushViewController(artistDetailViewController, animated: true)
    }
}
