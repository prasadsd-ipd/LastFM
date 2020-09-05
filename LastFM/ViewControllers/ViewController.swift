//
//  ViewController.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 05/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: VCViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    private enum AlertType {
        case noAlbumDataAvailable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

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

