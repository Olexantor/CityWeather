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
    let windDirEng: String
    let pressure: Int
    let humidity: Int
    
    init?(data: CurrentWeatherData) {
        nameOfCity = data.geo_object.locality.name
        temp = data.fact.temp
        tempFeelsLike = data.fact.tempFeelsLike
        condition = data.fact.condition
        windSpeed = data.fact.windSpeed
        windDirEng = data.fact.windDirection
        pressure = data.fact.pressure
        humidity = data.fact.humidity
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
            return "rainyday"
        case "moderate-rain":
            return "rainyday"
        case "heavy-rain":
            return "rainyday"
        case "continuous-heavy-rain":
            return "rainyday"
        case "showers":
            return "heavy"
        case "wet-snow":
            return "wetsnow"
        case "light-snow":
            return "lightsnow"
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
            return "thundersthail"
        default:
            return "cloudy"
        }
    }
    var tempString: String {
        switch temp {
        case 1...100:
            return "Температура: +\(temp)ºC"
        default:
            return "Температура: \(temp)ºC"
        }
    }
    var tempFeelsLikeString: String {
        switch tempFeelsLike {
        case 1...100:
            return "Ощущается как: +\(tempFeelsLike)ºC"
        default:
            return "Ощущается как: \(tempFeelsLike)ºC"
        }
    }
    
    var windDirRus: String {
        switch windDirEng {
        case "nw":
            return "Направление: СЗ"
        case "n":
            return "Направление: С"
        case "ne":
            return "Направление: СВ"
        case "e":
            return "Направление: В"
        case "se":
            return "Направление: ЮВ"
        case "s":
            return "Направление: Ю"
        case "sw":
            return "Направление: ЮЗ"
        case "w":
            return "Направление: З"
        default:
            return "Штиль"
        }
    }
    
    var windSpeedString: String {
        "Ветер: \(windSpeed) м/с"
    }
    
    var pressureString: String {
        "Давление: \(pressure) мм.рт.ст."
    }
    
    var humidityString: String {
        "Влажность: \(humidity)%"
    }
}
