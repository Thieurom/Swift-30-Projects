//
//  ViewController.swift
//  Stopwatch
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Data
    
    private let cellId = "CellId"
    let stopwatch = Stopwatch()
    var laps = [TimeInterval]()
    
    // MARK: - Views
    
    lazy var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 80, weight: .thin)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "00:00.00"
        
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Start", for: .normal)
        button.setTitle("Stop", for: .selected)
        
        button.layer.cornerRadius = 40
        
        return button
    }()
    
    lazy var lapButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Lap", for: .normal)
        button.backgroundColor = .mineShaft
        button.setTitleColor(.osloGray, for: .normal)
        button.layer.cornerRadius = 40
        
        return button
    }()
    
    lazy var lapsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .woodsmoke
        tableView.separatorColor = .osloGray
        
        return tableView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        configButtons()
    }
    
    // MARK: - Action methods
    
    @objc private func startButtonTapped(_ button: UIButton) {
        if !stopwatch.isRunning {
            button.isSelected = true
            
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateElapsedTime(_:)), userInfo: nil, repeats: true)

            stopwatch.start()
        } else {
            button.isSelected = false
            stopwatch.pause()
        }
        
        updateButtons()
    }
    
    @objc private func lapButtonTapped(_ button: UIButton) {
        if stopwatch.isRunning {
            addNewLap()
        } else if button.isEnabled {
            button.isEnabled = false
            stopwatch.stop()
            laps.removeAll()
            
            lapsTableView.reloadData()
            updateButtons()
            updateElapsedTimeLabel()
        }
    }
    
    // MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailTableViewCell
        
        config(cell, at: indexPath)
        
        return cell
    }
}

// ========================================================================================================
// MARK: - Private helpers

private extension ViewController {
    
    // MARK: - Config views
    
    func setUpView() {
        view.backgroundColor = .woodsmoke
        title = "Stopwatch"
        
        view.addSubview(elapsedTimeLabel)
        view.addSubview(startButton)
        view.addSubview(lapButton)
        view.addSubview(lapsTableView)
        
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        lapButton.translatesAutoresizingMaskIntoConstraints = false
        lapsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        
        // label
        NSLayoutConstraint.activate([
            elapsedTimeLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            elapsedTimeLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            elapsedTimeLabel.heightAnchor.constraint(equalTo: elapsedTimeLabel.widthAnchor, multiplier: 1)])
        
        // buttons
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 80),
            startButton.topAnchor.constraint(equalTo: elapsedTimeLabel.bottomAnchor),
            startButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            lapButton.widthAnchor.constraint(equalToConstant: 80),
            lapButton.heightAnchor.constraint(equalToConstant: 80),
            lapButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            lapButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)])
        
        // table view
        NSLayoutConstraint.activate([
            lapsTableView.topAnchor.constraint(equalTo: startButton.bottomAnchor),
            lapsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lapsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lapsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        lapsTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: cellId)
        lapsTableView.dataSource = self
    }
    
    func configButtons() {
        startButton.addTarget(self, action: #selector(ViewController.startButtonTapped(_:)), for: .touchUpInside)
        lapButton.addTarget(self, action: #selector(ViewController.lapButtonTapped(_:)), for: .touchUpInside)
        
        // disable lapButton at launch
        lapButton.isEnabled = false
        
        updateButtons()
    }
    
    func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let index = laps.count - indexPath.row
        let lap = laps[index - 1]
        
        cell.textLabel?.text = "Lap \(index)"
        cell.detailTextLabel?.text = elapsedTimeString(elapsedTime: lap)
    }
    
    // MARK: - Update views
    
    func updateButtons() {
        if stopwatch.isRunning {
            lapButton.isEnabled = true
        }
        
        if lapButton.isEnabled {
            lapButton.setTitleColor(.white, for: .normal)
        } else {
            lapButton.setTitleColor(.osloGray, for: .normal)
            lapButton.setTitle("Lap", for: .normal)
        }
        
        if startButton.isSelected {
            startButton.backgroundColor = .vanCleef
            startButton.setTitleColor(.redOrange, for: .normal)
            
            lapButton.setTitle("Lap", for: .normal)
        } else {
            startButton.backgroundColor = .zuccine
            startButton.setTitleColor(.malachite, for: .normal)
            
            if lapButton.isEnabled {
                lapButton.setTitle("Reset", for: .normal)
            }
        }
    }
    
    @objc func updateElapsedTime(_ timer: Timer) {
        if stopwatch.isRunning {
            updateElapsedTimeLabel()
            
            if laps.isEmpty {
                addNewLap()
            } else {
                updateLastLap()
            }
        } else {
            timer.invalidate()
        }
    }
    
    func addNewLap() {
        let totalElapsedTime = laps.reduce(0, +)
        let newLap = stopwatch.elapsedTime - totalElapsedTime
        
        laps.append(newLap)
        lapsTableView.reloadData()
    }
    
    func updateLastLap() {
        let totalElapsedTime = laps.reduce(0, +)
        laps[laps.count - 1] += stopwatch.elapsedTime - totalElapsedTime
        lapsTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    func updateElapsedTimeLabel() {
        elapsedTimeLabel.text = elapsedTimeString(elapsedTime: stopwatch.elapsedTime)
    }
    
    // MARK: - Utilities
    
    func elapsedTimeString(elapsedTime: TimeInterval) -> String {
        return String(format: "%02d:%02d.%02d", Int(elapsedTime / 60), Int(elapsedTime.truncatingRemainder(dividingBy: 60)), Int((elapsedTime * 100).truncatingRemainder(dividingBy: 100)))
    }
}
