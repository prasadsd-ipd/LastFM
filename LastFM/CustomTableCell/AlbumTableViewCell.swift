//
//  AlbumTableViewCell.swift
//  LastFM
//
//  Created by Durga Prasad, Sidde (623-Extern) on 06/09/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    //MARK:- Properties
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumArtist: UILabel!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        albumImageView.layer.cornerRadius = albumImageView.frame.size.height/2
        albumImageView.clipsToBounds = true
        albumImageView.layer.borderColor = UIColor.darkGray.cgColor
        albumImageView.layer.borderWidth = 2.0
    }

    //Configuring Cell
    func configure(with modelView: AlbumPresentable) {
        albumTitle.text = modelView.name
        albumArtist.text = modelView.artist
        albumImageView.loadThumbnail(urlSting: modelView.albumImage)
    }
}
