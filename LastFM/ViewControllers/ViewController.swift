//
//  ViewController.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    var viewModel: VCViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    @IBOutlet weak var albumsTableView: UITableView!
    
    private var searchController: UISearchController!
    
    private enum AlertType {
        case noAlbumDataAvailable
    }
    
    //MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Configuring search controller
        configureSearchController()
    }

    //MARK:- Custom Methods
    private func setupViewModel(with viewModel: VCViewModel) {
        // Configure View Model
        viewModel.didFetchData = { [weak self] (searchData, error) in
            if let _ = error {
                // Notify User
                DispatchQueue.main.async {
                    self?.presentAlert(of: .noAlbumDataAvailable)
                }
            } else if let searchData = searchData {
                debugPrint(searchData)
                //Updating table with search result
                DispatchQueue.main.async {
                    self?.albumsTableView.reloadData()
                }
            } else {
                // Notify User
                DispatchQueue.main.async {
                    self?.presentAlert(of: .noAlbumDataAvailable)
                }
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
        case .noAlbumDataAvailable:
            title = "Unable to Fetch  Data"
            message = "The application is unable to fetch ablum data. Please make sure your device is connected Internet"
        }
        
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "Got It", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
        present(alertController, animated: true)
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
        
    private func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search album <taylor>"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Placeing the search bar to the tableview headerview.
        albumsTableView.tableHeaderView = searchController.searchBar
    }

    //MARK:- UISearchResultsUpdating methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        //Setting up min string length
        if searchString.count > 2 {
            self.viewModel?.searchAlbums(with: searchString)
        }
    }
}

//MARK:- UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfAlbums ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating Table Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseIdentifier, for: indexPath) as? AlbumTableViewCell else {
            fatalError("Unable to DequeueTable View Cell")
        }

        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Configure Cell
        cell.configure(with: viewModel.cellViewModel(for: indexPath.row))
        return cell
    }
}
