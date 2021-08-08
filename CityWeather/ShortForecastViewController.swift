//
//  ShortForecastViewController.swift
//  CityWeather
//
//  Created by Александр on 01.08.2021.
//

import UIKit

class ShortForecastViewController: UITableViewController {
    
    var cities = StorageManager.shared.cities

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
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
    // Setup TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        cities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shortForecastCell", for: indexPath)
        
        let city = cities[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = city
        
        return cell
        
    }
}

