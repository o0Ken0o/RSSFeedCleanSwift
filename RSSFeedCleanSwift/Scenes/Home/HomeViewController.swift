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
    func display(errorViewModel: Home.FetchSongs.ViewModel.Error)
    func displayEmptySongsList()
}

class HomeViewController: UIViewController {
    var router: HomeRoutingLogic?
    var interactor: HomeBusinessLogic?
    var tableView = UITableView()
    var emptySongsListMsgView = UIScrollView()
    var errorSongsListMsgView = UIScrollView()
    var errorImgView = UIImageView()
    var errorMsgLabel = UILabel()
    
    let refreshControlCreation: () -> UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to reload", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(pullDownToRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
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
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        tableView.refreshControl = refreshControlCreation()
        
        setupEmptySongsListView()
        setupErrorSongsListView()
    }
    
    func setupEmptySongsListView() {
        self.view.addSubview(emptySongsListMsgView)
        emptySongsListMsgView.isHidden = true
        emptySongsListMsgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            var height: CGFloat = 88
            if let navBarHeight = self.navigationController?.navigationBar.frame.height {
                height = navBarHeight + UIApplication.shared.statusBarFrame.height
            }
            make.top.equalToSuperview().offset(height)
        }
        
        emptySongsListMsgView.refreshControl = refreshControlCreation()
        
        let emptyViewTitle = UILabel()
        emptyViewTitle.backgroundColor = .clear
        emptySongsListMsgView.addSubview(emptyViewTitle)
        emptyViewTitle.text = "No songs available"
        emptyViewTitle.textAlignment = .center
        emptyViewTitle.font = .boldSystemFont(ofSize: 18)
        emptyViewTitle.backgroundColor = .white
        emptyViewTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
    }
    
    func setupErrorSongsListView() {
        self.view.addSubview(errorSongsListMsgView)
        errorSongsListMsgView.isHidden = true
        errorSongsListMsgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            var height: CGFloat = 88
            if let navBarHeight = self.navigationController?.navigationBar.frame.height {
                height = navBarHeight + UIApplication.shared.statusBarFrame.height
            }
            make.top.equalToSuperview().offset(height)
        }
        
        errorSongsListMsgView.refreshControl = refreshControlCreation()
        
        errorSongsListMsgView.addSubview(errorImgView)
        errorImgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalTo(view)
            make.width.height.equalTo(100)
        }
        
        errorSongsListMsgView.addSubview(errorMsgLabel)
        errorMsgLabel.snp.makeConstraints { (make) in
            make.top.equalTo(errorImgView.snp.bottom).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
    }
    
    @objc func pullDownToRefresh(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.endRefreshing()
        }
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displaySongs(viewModel: Home.FetchSongs.ViewModel) {
        displaySongs = viewModel.songs
        tableView.reloadData()
    }
    
    func displayEmptySongsList() {
        tableView.isHidden = true
        emptySongsListMsgView.isHidden = false
        errorSongsListMsgView.isHidden = true
        
        emptySongsListMsgView.contentSize = emptySongsListMsgView.frame.size
        emptySongsListMsgView.alwaysBounceVertical = true
    }
    
    func display(errorViewModel: Home.FetchSongs.ViewModel.Error) {
        tableView.isHidden = true
        emptySongsListMsgView.isHidden = true
        errorSongsListMsgView.isHidden = false
        
        emptySongsListMsgView.contentSize = errorSongsListMsgView.frame.size
        errorSongsListMsgView.alwaysBounceVertical = true
        
        errorImgView.image = UIImage(named: errorViewModel.errorImgName)
        errorMsgLabel.text = errorViewModel.msg
        errorMsgLabel.textAlignment = .center
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
