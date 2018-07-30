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

class ArtistDetailViewController: UIViewController {
    
    var artist: Artist
    let moreInfoText = "Select For More Info >"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Initialization
    
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.title = artist.name
        
        // table view
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "WorkTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    private func configCell(_ cell: WorkTableViewCell, with work: Work) {
        cell.workImageView.image = work.image
        
        cell.workTitleLabel.text = work.title
        cell.workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
        cell.workTitleLabel.textAlignment = .center
        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textColor = UIColor(white: 114 / 255, alpha: 1)
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        cell.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
}

// MARK: - UITableView Data Source

extension ArtistDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as? WorkTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        let work = artist.works[indexPath.row]
        configCell(cell, with: work)
        
        return cell
    }
}

// MARK: - UITable View Delegate

extension ArtistDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {
            return
        }
        
        var work = artist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        artist.works[indexPath.row] = work
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
