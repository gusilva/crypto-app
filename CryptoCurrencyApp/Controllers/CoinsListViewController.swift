import UIKit

class CoinsListViewController: UIViewController {
  var coins: [Coin] = []
  let tableView = UITableView()
  
  override func loadView() {
    super.loadView()
    
    configureTableView()
    getCoins()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
    super.viewWillDisappear(animated)
  }
}

private extension CoinsListViewController {
  func configureTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.rowHeight = 48
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseID)
    tableView.separatorStyle = .none
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      
    ])
  }
  
  func getCoins() {
    CoinService.shared.fetchCoins { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let coins):
        self.coins = coins
        DispatchQueue.main.async {
          self.tableView.reloadData()
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
    return coins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let coin = coins[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseID, for: indexPath) as! CoinTableViewCell
    cell.coin = coin
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let coin = coins[indexPath.row]
    
    let coinDetailViewController = CoinDetailViewController(coinName: coin.name, isActive: coin.isActive)
    
    //    navigationController?.pushViewController(coinDetailViewController, animated: true)
    navigationController?.show(coinDetailViewController, sender: self)
  }
}
