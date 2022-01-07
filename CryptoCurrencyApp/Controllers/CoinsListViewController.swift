import UIKit

class CoinsListViewController: UIViewController {
  var coins: [Coin] = []
  let tableView = UITableView()
  
  override func loadView() {
    super.loadView()
    
    configureTableView()
    getCoins()
  }
}

private extension CoinsListViewController {
  func configureTableView() {
    view.addSubview(tableView)
    
    tableView.frame = view.bounds
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
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
      case .failure(_):
        break
      }
    }
  }
}

extension CoinsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return coins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let coin = coins[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.textLabel?.text = coin.name
    
    return cell
  }
}
