//
//  SongTableViewCell.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 12/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    static let identifier = "SongTableViewCell"
    
    let albumThumbnail = UIImageView()
    let artistNameLabel = UILabel()
    
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
//        artistNameLabel.backgroundColor = .orange
    }
    
    func configureWith(thumbnail: String, name: String) {
        artistNameLabel.text = name
    }
}
