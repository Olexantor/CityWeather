//
//  ShortForecastViewController.swift
//  CityWeather
//
//  Created by Александр on 01.08.2021.
//

import UIKit
import SnapKit

class ShortForecastViewController: UIViewController {
    
    private var cities = StorageManager.shared.cities
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shortForecastCell")
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupNavigationBar() {
        title = "Short forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //Add button to Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewCity)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewCity() {
        
    }
}

extension ShortForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "shortForecastCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
}

extension ShortForecastViewController: UITableViewDelegate {
    
}

