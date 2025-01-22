//
//  AirlineNetwork.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/8/25.
//

import Foundation

protocol SearchNetworkProtocol {
    func getSearchResults(searchText: String, completion: @escaping (Result<AirlineData, NetworkError>) -> Void)
}

class SearchNetwork: SearchNetworkProtocol {
    private var urlComponents: URLComponents
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.duckduckgo.com"
        urlComponents.path = "/"
    }
    
    func getSearchResults(searchText: String, completion: @escaping (Result<AirlineData, NetworkError>) -> Void) {

        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "pretty", value: "1")
        ]
        
        guard let url = urlComponents.url else {
            print("Error: Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network Error: \(error.localizedDescription)")
                    completion(.failure(.noData))
                    return
                }
                
                guard let data = data else {
                    print("Error: No data received")
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(AirlineData.self, from: data)
                        print("Decoded successfully")
                        completion(.success(decodedData))
                    
                } catch {
                    print("Decoding Error: \(error.localizedDescription)")
                    completion(.failure(NetworkError.decodingFailed))
                }
            }
            task.resume()
        }
    }

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
}

