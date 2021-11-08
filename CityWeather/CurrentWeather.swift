//
//  CurrentWeather.swift
//  CityWeather
//
//  Created by Александр on 03.11.2021.
//

import Foundation

struct CurrentWeather {
    let nameOfCity: String
    let temp: Int
    let tempFeelsLike: Int
    let condition: String
    let windSpeed: Double
    let windDirection: String
    let pressure: Int
    let humidity: Int
    
    init?(data: CurrentWeatherData) {
        nameOfCity = data.geo_object.locality.name
        temp = data.fact.temp
        tempFeelsLike = data.fact.tempFeelsLike
        condition = data.fact.condition
        windSpeed = data.fact.windSpeed
        windDirection = data.fact.windDirection
        humidity = data.fact.humidity
        pressure = data.fact.humidity
    }
        
    var conditionName: String {
        switch condition {
        case "clear":
            return "sunnyday"
        case "cloudy":
            return "cloudy"
        case "overcast":
            return "over"
        case "drizzle":
            return "driz"
        case "light-rain":
            return "lightrain"
        case "rain":
            return "raynyday"
        case "moderate-rain":
            return "rainyday"
        case "heavy-rain":
            return "rainyday"
        case "continuous-heavy-rain":
            return "rainyday"
        case "showers":
            return "heavy"
        case "wet-snow":
            return "wet-snow"
        case "light-snow":
            return "light-snow"
        case "snow":
            return "snow"
        case "snow-showers":
            return "snowshow"
        case "hail":
            return "hail"
        case "thunderstorm":
            return "thunderst"
        case "thunderstorm-with-rain":
            return "thunderrain"
        case "thunderstorm-with-hail":
            return "thunderhail"
        default:
            return "cloudy"
        }
    }
  
}
