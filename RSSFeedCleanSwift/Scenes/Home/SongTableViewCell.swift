//
//  SongTableViewCell.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 12/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SDWebImage

class SongTableViewCell: UITableViewCell {
    static let identifier = "SongTableViewCell"
    
    var albumThumbnail = UIImageView()
    var artistNameLabel = UILabel()
    var albumNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(albumThumbnail)
        self.contentView.addSubview(artistNameLabel)
        self.contentView.addSubview(albumNameLabel)
        
        self.backgroundColor = .black
        
        albumThumbnail.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(albumThumbnail.snp.height)
        }
        
        artistNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(albumThumbnail.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        artistNameLabel.textColor = .white
        artistNameLabel.font = .systemFont(ofSize: 18)
        
        albumNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(artistNameLabel)
            make.bottom.equalToSuperview().offset(-5)
        }
        albumNameLabel.textColor = .lightGray
        albumNameLabel.font = .systemFont(ofSize: 15)
    }
    
    func configureWith(displaySong: Home.FetchSongs.ViewModel.DisplaySong) {
        artistNameLabel.text = displaySong.artistName
        albumNameLabel.text = displaySong.collectionName
        guard let url = URL(string: displaySong.artworkUrl100) else { return }
        albumThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: "album_placeholder"))
    }
}
