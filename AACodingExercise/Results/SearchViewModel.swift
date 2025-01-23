//
//  AirlineViewModel.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/8/25.
//

import Foundation
import CoreData

class SearchViewModel {
    var results: [ResultItem] = []
    var relatedTopics: [RelatedTopic] = []
    
    private let searchNetwork: SearchNetworkProtocol
    weak var delegate: SearchDelegates?
    
    init(searchNetwork: SearchNetworkProtocol) {
        self.searchNetwork = searchNetwork
    }
    
    func numberOfRows(in section: Int) -> Int {
        if section == 0 {
            print("Returning \(results.count) rows for RESULTS")
            return results.count
        } else {
            print("Returning \(relatedTopics.count) rows for RELATED TOPICS")
            return relatedTopics.count
        }
    }
    
    func titleForSection(_ section: Int) -> String {
        return section == 0 ? "RESULTS" : "RELATED TOPICS"
    }
    
    func item(for indexPath: IndexPath) -> (text: String, url: String) {
        guard results.count > indexPath.row else {
            return (text: "", "")
        }
        if indexPath.section == 0 {
            let result = results[indexPath.row]
            return (result.text ?? "No text available", result.firstURL ?? "No text available")
        } else {
            let topic = relatedTopics[indexPath.row]
            return (topic.text ?? "No text available", topic.firstURL ?? "No URL available")
        }
    }
    
    func performSearch(with searchText: String) {
        guard !searchText.isEmpty else {
            print("Search text is empty")
            return
        }
        
        searchNetwork.getSearchResults(searchText: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let airline): //refer to 46 min mark
                self.results = airline.results ?? []
                self.relatedTopics = airline.relatedTopics ?? []
                
                let context = CoreDataManager.shared.persistentContainer.viewContext
                let airlines = self.fetchAllEntities(context: context)
                if self.checkIfAirlineExists(searchText: searchText, airlines: airlines ?? []){
                    print("Airline already exists")
                } else {
                    addToAirlineEntity(context: context, airline: airline, name: searchText)
                    CoreDataManager.shared.saveContext()
                }
                self.delegate?.refreshUI()
                
            case .failure(let error):
                let context = CoreDataManager.shared.persistentContainer.viewContext
                let airline = self.fetchAllEntities(context: context)?.first
                if let airline = airline {
                    
                    if let results = airline.results?.allObjects as? [ResultEntity] {
                        for fetchedResult in results {
                            let furl = fetchedResult.firstURL
                            let text = fetchedResult.text
                            self.results.append(ResultItem(firstURL: furl ?? "", text: text ?? ""))
                        }
                    }
                    
                    if let relatedTopics = airline.relatedTopics?.allObjects as? [TopicEntity] {
                        for fetchedTopic in relatedTopics {
                            let furl = fetchedTopic.firstURL
                            let text = fetchedTopic.text
                            self.relatedTopics.append(RelatedTopic(firstURL: furl ?? "", text: text ?? ""))
                        }
                    }
                }
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func addToAirlineEntity(context: NSManagedObjectContext, name: String, airline: AirlineData) {
        
        let airlineEntity = AirlineEntity(context: context)
        airlineEntity.name = name
        
        for resultItem in airline.results {
            let resultEntity = ResultEntity(context: context)
            resultEntity.firstURL = resultItem.firstURL
            resultEntity.text = resultItem.text
            
            airlineEntity.addToResultEntity(resultEntity)
            resultEntity.airlineEntity = airlineEntity
        }
        
        for relatedTopic in airline.relatedTopics {
            let topicEntity = TopicEntity(context: context)
            topicEntity.firstURL = relatedTopic.firstURL
            topicEntity.text = relatedTopic.text
            
            airlineEntity.addToTopicEntity(topicEntity)
            topicEntity.airlineEntity = airlineEntity
        }
    }
    
    func fetchAllEntities(context: NSManagedObjectContext) -> [AirlineEntity]? {
        let fetchRequest = AirlineEntity.fetchRequest() // how to create an object of a fetchrequest
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch: \(error.localizedDescription)")
            return nil
        }
    }
    
    func checkIfAirlineExists(searchText: String, airlines: [AirlineEntity]) -> Bool {
        for airline in airlines {
            if let name = airline.name, name == searchText {
                return true
            }
        }
        return false
    }
}
