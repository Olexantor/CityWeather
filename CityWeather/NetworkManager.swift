//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Александр on 22.09.2021.
//

import Foundation
import CoreLocation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    
    func fetchCurrentWeather() {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=59.6033400&lon=60.5787000&lang=en_US"
        let header: HTTPHeaders = [apiHeader: apiKey]
        AF.request(urlString, headers: header).validate().responseJSON { responseData in
            print(responseData)
            }
        }
    
    
    
    
    
    func getCoordinate(cityString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
