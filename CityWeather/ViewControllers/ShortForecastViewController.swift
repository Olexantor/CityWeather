//
//  ShortForecastViewController.swift
//  CityWeather
//
//  Created by Александр on 01.08.2021.
//

import UIKit
import SnapKit
import Alamofire
import RxAppState
import RxSwift

class ShortForecastViewController: UIViewController {
    
    private var cities = StorageManager.shared.cities
    private var tableView = UITableView()
    private var weatherInCitiesDic = [Int: CurrentWeather]()
    private var weatherInCities = [CurrentWeather]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredWeather = [CurrentWeather]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupSearchController()
        getWeatherInCities()
        setupTableView()
        UIApplication.shared.rx.appState
            .filter { $0 == .active }
            .subscribe( onNext: { [unowned self] _ in
                getWeatherInCities()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "shortForecastCell"
        )
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        title = "Погода сейчас"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(named: "baseColor")
        
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: UIControl.Event.primaryActionTriggered
        )
    }
    
    @objc private func searchButtonTapped(textField:UITextField) {
        searchBarButtonClicked(searchController.searchBar)
    }
    
    @objc private func addNewCity() {
        showAlert(
            with: "Добавление населенного пункта",
            and: "Напишите название населенного пункта для добавления его в список"
        )
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(
            title: "Сохранить",
            style: .default
        ) { _ in
            guard let city = alert.textFields?.first?.text, !city.isEmpty else { return }
            StorageManager.shared.save(city: city)
            self.getWeatherInCity()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ShortForecastViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if isFiltering {
            return filteredWeather.count
        }
        return weatherInCities.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "shortForecastCell",
            for: indexPath
        )
        var weather: CurrentWeather
        if isFiltering {
            weather = filteredWeather[indexPath.row]
        } else {
            weather = weatherInCities[indexPath.row]
        }
        var content = cell.defaultContentConfiguration()
        content.text = weather.nameOfCity
        content.secondaryText = weather.tempString
        content.image = UIImage(named: weather.conditionName)
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDelegate
extension ShortForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        var weather: CurrentWeather
        if isFiltering {
            weather = filteredWeather[indexPath.row]
        } else {
            weather = weatherInCities[indexPath.row]
        }
        let detailedForecastVC = DetailedForecastViewController(weather: weather)
        present(detailedForecastVC, animated: true)
        searchController.searchBar.text = ""
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Удалить"
        ) { (action, view, completionHandler) in
            StorageManager.shared.deleteCity(at: indexPath.row)
            self.weatherInCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - API Methods
extension ShortForecastViewController {
    private func getWeatherInCities() {
        NetworkManager.shared.getWeatherFor(
            cities: StorageManager.shared.cities
        ) { [weak self] (index,weather) in
            guard let self = self else { return }
            self.weatherInCitiesDic[index] = weather
            self.weatherInCities = self.weatherInCitiesDic
                .sorted(by: { $0.0 < $1.0 })
                .map { $0.value }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func getWeatherInCity() {
        guard let lastCity = StorageManager.shared.cities.last else { return }
        NetworkManager.shared.getWeatherFor(
            city: lastCity
        ) { [weak self] (weather) in
            guard let self = self else { return }
            self.weatherInCities.append(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - SearchResultsUpdating
extension ShortForecastViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchedText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchedText(_ searchText: String) {
        filteredWeather = weatherInCities.filter({ weather in
            return weather.nameOfCity.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

//MARK: - SearchBarDelegate
extension ShortForecastViewController: UISearchBarDelegate {
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        guard let textField = searchBar.text, !textField.isEmpty else { return }
        NetworkManager.shared.getWeatherFor(
            city: textField
        ) { [weak self] (weather) in
            guard let self = self else { return }
            let detailedForecastVC = DetailedForecastViewController(weather: weather)
            self.present(detailedForecastVC, animated: true)
            searchBar.text = ""
        }
    }
}


