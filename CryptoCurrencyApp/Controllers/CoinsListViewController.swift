import UIKit

class CoinsListViewController: DataLoadingViewController {
  
  var allCoins: [Coin] = []
  var filteredCoins: [Coin] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  let tableView = UITableView()
  
  override func loadView() {
    super.loadView()
    title = "Coins"
    
    configureTableView()
    configureSearchController()
    getCoins()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    super.viewWillAppear(animated)
  }
}

private extension CoinsListViewController {
  func configureTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.rowHeight = 48
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseIdentifier)
    tableView.separatorStyle = .none
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      
    ])
  }
  
  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = NSLocalizedString("SEARCH_PLACEHOLDER", comment: "search placeholder")
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.definesPresentationContext = true
    
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
  }
  
  func getCoins() {
    showLoading()
    CoinService.shared.fetchCoins { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let coins):
        self.allCoins = coins
        self.filteredCoins = coins
        
        DispatchQueue.main.async {
          self.dismissLoadingView()
        }
      case .failure(let error):
        print(error)
        break
      }
    }
  }
}

extension CoinsListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredCoins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let coin = filteredCoins[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseIdentifier, for: indexPath) as! CoinTableViewCell
    cell.coin = coin
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let coin = filteredCoins[indexPath.row]
    
    let coinDetailViewController = CoinDetailViewController(coinName: coin.label, coinId: coin.id)
    coinDetailViewController.modalPresentationStyle = .overFullScreen
    
    navigationController?.show(coinDetailViewController, sender: self)
  }
}

extension CoinsListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      filteredCoins = allCoins
      return
    }
    
    filteredCoins = allCoins.filter({ $0.label.lowercased().contains(filter.lowercased()) })
  }
}
