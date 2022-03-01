//
//  HomeViewController.swift
//  CHWallet
//
//  Created by Ty Pham on 01/03/2022.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(delegate: self)
        
        //register cell
        tableView.registerCellFromNib(CoinTableViewCell.self)
        
        
        // initializing the refreshControl
        tableView.refreshControl = UIRefreshControl()
        // add target to UIRefreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData()
    }
    
    
    @objc func pullToRefresh() {
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
    func dataDidLoad() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func dataLoadError(error: String) {
        self.tableView.refreshControl?.endRefreshing()
        self.showErrorAlert(error: error)
    }
}

//MARK: SearchDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(keyword: searchText)
    }
}
