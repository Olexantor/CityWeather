//
//  DataManager.swift
//  CityWeather
//
//  Created by Александр on 03.08.2021.
//

class DataManager {
  
  static let share = DataManager()
  
  let cities = [
    "Abakan",
    "Barnaul",
    "Gdov",
    "Dubna",
    "Yekaterinburg",
    "Zlatoust",
    "Izhevsk",
    "Yoshkar-Ola",
    "Kazan",
    "Serov"
  ]
  
  private init() {}
}
