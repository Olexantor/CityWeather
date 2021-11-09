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
    let windSpeed: String
    let windDirEng: String
    let pressure: Int
    let humidity: Int
    
    init?(data: CurrentWeatherData) {
        nameOfCity = data.geo_object.locality.name
        temp = data.fact.temp
        tempFeelsLike = data.fact.tempFeelsLike
        condition = data.fact.condition
        windSpeed = String(data.fact.windSpeed)
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
    var tempString: String {
        switch temp {
        case 1...100:
            return "+\(temp)ºC"
        default:
            return "\(temp)ºC"
        }
    }
    var tempFeelsLikeString: String {
        switch tempFeelsLike {
        case 1...100:
            return "+\(tempFeelsLike)ºC"
        default:
            return "\(tempFeelsLike)ºC"
        }
    }
    
    var windDirRus: String {
        switch windDirEng {
        case "nw":
            return "Северо-западное"
        case "n":
            return "Cеверное"
        case "ne":
            return "Cеверо-восточное"
        case "e":
            return "Восточное"
        case "se":
            return "Юго-восточное"
        case "s":
            return "Южное"
        case "sw":
            return "Юго-западное"
        case "w":
            return "Западное"
        default:
            return "Штиль"
        }
    }
    
    var pressureString: String {
        return "\(pressure)мм.рт.ст."
    }
    
    var humidityString: String {
        return "\(humidity)%"
    }
}
