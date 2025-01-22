//
//  SearchableAPIClient.swift
//  AACodingExerciseTests
//
//  Created by Dancilia Harmon   on 1/19/25.
//

import Foundation
@testable import AACodingExercise

class SearchableAPIClient: SearchNetworkProtocol {
    var isSuccess = true
    func getSearchResults(searchText: String, completion: @escaping (Result<AACodingExercise.AirlineData, AACodingExercise.NetworkError>) -> Void) {
         
        if isSuccess {
            completion(.success(AirlineData(relatedTopics: [RelatedTopic(firstURL: "https://duckduckgo.com/US_Airways", text: "US Airways , which merged with American Airlines in 2015.")], results: [ResultItem(firstURL: "https://duckduckgo.com/AAirpass", text: "AAirpass - AAirpass was a membership-based discount program offered by American Airlines to frequent flyers launched in 1981. The program offered pass holders free flights and unlimited access to Admirals Club locations for either five years or life.")])))
        } else {
            completion(.failure(NetworkError.noData))
        }
    }
    
    
}
