//
//  AirlineViewController.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/8/25.
//

import UIKit // handles user input, communicated with the view model, and displays search results in a table view

protocol SearchDelegates: AnyObject {
    func refreshUI()
    func showError(message: String)
}

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    func saveAirlines() {

    }
    
    private let searchViewModel: SearchViewModel
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .systemGray6
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ResultsTableViewCell.self, forCellReuseIdentifier: "ResultsTableViewCell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return table
    }()
    
    init(viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        setupUI()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}

extension SearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchViewModel.performSearch(with: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchViewModel.results = []
            searchViewModel.relatedTopics = []
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = searchViewModel.titleForSection(section)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as? ResultsTableViewCell else {
            fatalError("Unable to dequeue ResultsTableViewCell")
        }
        
        let itemData = searchViewModel.item(for: indexPath)
        cell.configure(title: itemData.text, subtitle: itemData.url)
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        let secondViewController = SecondViewController()
        secondViewController.title = "Row \(sender.tag)"
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = SecondViewController()
        let itemData = searchViewModel.item(for: indexPath)
        secondViewController.title = itemData.text
        navigationController?.pushViewController(secondViewController, animated: true)
    }

}


extension SearchViewController: SearchDelegates {
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: message)
        }
    }
}
