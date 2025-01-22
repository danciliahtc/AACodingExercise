//
//  AirlineData.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/8/25.
//

import Foundation

struct AirlineData: Decodable {
    let relatedTopics: [RelatedTopic]?
    let results: [ResultItem]?
    
    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
        case results = "Results"
    }
}

struct ResultItem: Decodable {
    let firstURL: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case text = "Text"
    }
}

struct RelatedTopic: Decodable {
    let firstURL: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case text = "Text"
    }
}
