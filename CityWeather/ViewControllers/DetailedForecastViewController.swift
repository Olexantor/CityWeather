//
//  DetailedForecastViewController.swift
//  CityWeather
//
//  Created by Александр on 16.11.2021.
//

import UIKit

class DetailedForecastViewController: UIViewController {
  
  private let weather: CurrentWeather
  
  private let nameOfCityLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 35)
    textLabel.textAlignment = .center
    textLabel.numberOfLines = 0
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let weatherIcon: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    return view
  }()
  
  private let temperatureLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let temperatureFeelsLikeLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let windSpeedLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let windDirectionLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font =  UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let pressureLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  private let humidityLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.font = UIFont.boldSystemFont(ofSize: 14)
    textLabel.textAlignment = .center
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()
  
  init(weather: CurrentWeather) {
    self.weather = weather
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupSubviews()
    setConstraints()
    updateUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.3) {
      self.weatherIcon.alpha = 1
    }
  }
  
  private func setupSubviews() {
    view.addSubview(nameOfCityLabel)
    view.addSubview(weatherIcon)
    view.addSubview(temperatureLabel)
    view.addSubview(temperatureFeelsLikeLabel)
    view.addSubview(windSpeedLabel)
    view.addSubview(windDirectionLabel)
    view.addSubview(pressureLabel)
    view.addSubview(humidityLabel)
  }
  
  private func setConstraints() {
    nameOfCityLabel.snp.makeConstraints { maker in
      maker.top.equalToSuperview().inset(20)
      maker.left.right.equalToSuperview().inset(30)
      maker.bottom.equalTo(weatherIcon.snp.top).inset(-32)
    }
    
    weatherIcon.snp.makeConstraints { maker in
      maker.centerX.equalToSuperview()
      maker.size.equalTo(70)
      
    }
    
    temperatureLabel.snp.makeConstraints { maker in
      maker.top.equalTo(weatherIcon).inset(100)
      maker.centerX.equalToSuperview()
    }
    
    temperatureFeelsLikeLabel.snp.makeConstraints { maker in
      maker.top.equalTo(temperatureLabel).inset(30)
      maker.centerX.equalToSuperview()
    }
    
    windSpeedLabel.snp.makeConstraints { maker in
      maker.top.equalTo(temperatureFeelsLikeLabel).inset(50)
      maker.centerX.equalToSuperview()
    }
    
    windDirectionLabel.snp.makeConstraints { maker in
      maker.top.equalTo(windSpeedLabel).inset(30)
      maker.centerX.equalToSuperview()
    }
    
    pressureLabel.snp.makeConstraints { maker in
      maker.top.equalTo(windDirectionLabel).inset(50)
      maker.centerX.equalToSuperview()
    }
    
    humidityLabel.snp.makeConstraints { maker in
      maker.top.equalTo(pressureLabel).inset(30)
      maker.centerX.equalToSuperview()
    }
  }
  
  private func updateUI() {
    nameOfCityLabel.text = weather.nameOfCity
    weatherIcon.image = UIImage(named: weather.conditionName)
    temperatureLabel.text = weather.tempString
    temperatureFeelsLikeLabel.text = weather.tempFeelsLikeString
    windSpeedLabel.text = weather.windSpeedString
    windDirectionLabel.text = weather.windDirRus
    pressureLabel.text = weather.pressureString
    humidityLabel.text = weather.humidityString
  }
}
