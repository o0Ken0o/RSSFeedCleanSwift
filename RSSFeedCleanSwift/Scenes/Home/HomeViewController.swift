//
//  HomeViewController.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displaySongs(viewModel: Home.FetchSongs.ViewModel)
//    func displayErrorMsg()
//    func displayEmptySongsList()
}

class HomeViewController: UIViewController {
    var router: HomeRoutingLogic?
    var interactor: HomeBusinessLogic?
    var tableView = UITableView()
    
    // This list is just for display only. It is different from the one in HomeInteractor
    var displaySongs: [Home.FetchSongs.ViewModel.DisplaySong] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.view.backgroundColor = .lightGray
        
        setupVIPChain()
        setupViews()
        
        interactor?.fetchSongs()
    }
    
    func setupVIPChain() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.songSerivce = ServicesHolder.songService
        presenter.viewController = viewController
    }
    
    func setupViews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displaySongs(viewModel: Home.FetchSongs.ViewModel) {
        displaySongs = viewModel.songs
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displaySongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell else {
            return SongTableViewCell()
        }
        
        let displaySong = displaySongs[indexPath.row]
        cell.configureWith(displaySong: displaySong)
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
