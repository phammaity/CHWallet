//
//  HomeViewController.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(delegate: self)
        
        //configure tableview
        tableView.registerCellFromNib(CoinTableViewCell.self)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        //configure searchbar
        searchBar.placeholder = "Search by name"
        
        //configure observer
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            print("app active")
            self.viewModel?.fetchData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func pullToRefresh() {
        //end editting
        searchBar.text = ""
        searchBar.endEditing(true)
        
        //refresh
        viewModel?.fetchData()
    }
    
}

//MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CoinTableViewCell.self, forIndexPath: indexPath)
        
        if let coinVM = self.viewModel?.coinVM(at: indexPath.row) {
            cell.updateData(viewModel: coinVM)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Markets"
    }
}

//MARK: HomeDelegate
extension HomeViewController: HomeDelegate {
    func startLoading() {
        loadingStatusLabel.text = "Loading ..."
    }
    
    func dataDidLoad() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
        self.loadingStatusLabel.text = "Updated"
    }
    
    func dataLoadError(error: String) {
        self.tableView.refreshControl?.endRefreshing()
        self.showErrorAlert(error: error)
        self.loadingStatusLabel.text = "ERROR!!!"
    }
}

//MARK: SearchDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(keyword: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
