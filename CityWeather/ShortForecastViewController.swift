//
//  ShortForecastViewController.swift
//  CityWeather
//
//  Created by Александр on 01.08.2021.
//

import UIKit
import SnapKit
import Alamofire

class ShortForecastViewController: UIViewController {
    
    
    private var cities = StorageManager.shared.cities
    private var tableView = UITableView()
    var weatherInCities = [Int: CurrentWeather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        getCitiesWeather()
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
        showAlert(with: "Add a new city", and: "Write the name of the city in English with a capital letter")
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let city = alert.textFields?.first?.text, !city.isEmpty else { return }
            StorageManager.shared.save(city: city)
            let cellIndex = IndexPath(row: StorageManager.shared.cities.count - 1, section: 0)
            self.tableView.insertRows(at: [cellIndex], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ShortForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherInCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shortForecastCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = weatherInCities[indexPath.row]?.nameOfCity
        content.secondaryText = weatherInCities[indexPath.row]?.tempString
        content.image = UIImage(named: weatherInCities[indexPath.row]?.conditionName ?? "thundersthail")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDelegate
extension ShortForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            StorageManager.shared.deleteCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
// MARK: - API Methods
extension ShortForecastViewController {
    func getCitiesWeather() {
        NetworkManager.shared.getCityWeather(cities: cities) { [weak self] (index,weather) in
            guard let self = self else { return }
            self.weatherInCities[index] = weather
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

