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
    
    private func fetchCurrentWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<CurrentWeather, Error>) -> Void
    ) {
        
        let url = urlYandex + "lat=" + String(latitude) + "&lon=" + String(longitude)
        let header: HTTPHeaders = [apiHeader: apiKey]
        AF.request(url, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else { return }
                    let json = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
                    guard let weather = CurrentWeather(data: json) else { return }
                    completion(.success(weather))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeatherFor(city: String, completion: @escaping (CurrentWeather) -> Void) {
        getCoordinate(cityString: city) { coordinate, error in
            if error == nil {
                self.fetchCurrentWeather(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude) { result in
                    
                    switch result {
                    
                    case .success(let weather):
                        completion(weather)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getWeatherFor(cities:[String], completion: @escaping (Int, CurrentWeather) -> Void) {
        for (index, city) in cities.enumerated() {
            getCoordinate(cityString: city) { coordinate, error in
                if error == nil {
                    self.fetchCurrentWeather(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude) { result in
                        
                        switch result {
                        
                        case .success(let weather):
                            completion(index, weather)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    
    private  func getCoordinate(cityString : String,
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
    private init() {}
}
