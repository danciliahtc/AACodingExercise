//
//  SearchViewModelTests.swift
//  AACodingExerciseTests
//
//  Created by Dancilia Harmon   on 1/19/25.
//

import XCTest
@testable import AACodingExercise

final class SearchViewModelTests: XCTestCase {
    
    var vm: SearchViewModel!
    let searchableAPIClient = SearchableAPIClient()
    
    override func setUp() {
        vm = SearchViewModel(searchNetwork: searchableAPIClient)
    }
    
    override func tearDown() {
        vm = nil
    }
    
    func test_performSearch_success() {
        // GIVEN
        let searchText = "test"
        // WHEN
        XCTAssertEqual(vm.results.count, 0)
        vm.performSearch(with: searchText)
        // THEN
        XCTAssertEqual(vm.results.count, 1)
    }
    
    func test_performSearch_failure() {
        // GIVEN
        let searchText = "test"
        // WHEN
        searchableAPIClient.isSuccess = false
        XCTAssertEqual(vm.results.count, 0)
        vm.performSearch(with: searchText)
        // THEN
        XCTAssertEqual(vm.results.count, 0)
    }
    
    func test_item_empty_data() {
        // GIVEN
        let indexPath = IndexPath(row: 0, section: 0)
        // WHEN
        let item = vm.item(for: indexPath)
        // THEN
        XCTAssertEqual(item.text, "")
        XCTAssertEqual(item.url, "")
    }
    
    func test_item_with_data() {
        // GIVEN
        let searchText = "test"
        vm.performSearch(with: searchText)
        let indexPath = IndexPath(row: 0, section: 0)
        // WHEN
        let item = vm.item(for: indexPath)
        // THEN
        XCTAssertEqual(item.text, "AAirpass - AAirpass was a membership-based discount program offered by American Airlines to frequent flyers launched in 1981. The program offered pass holders free flights and unlimited access to Admirals Club locations for either five years or life.")
        XCTAssertEqual(item.url, "https://duckduckgo.com/AAirpass")
    }
}
