import UIKit

class CoinsListViewController: UIViewController {
  
  let tableView = UITableView()
  
  override func loadView() {
    super.loadView()
    
    configureTableView()
  }
}

private extension CoinsListViewController {
  func configureTableView() {
    view.addSubview(tableView)
    
    tableView.frame = view.bounds
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    
  }
}

extension CoinsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    cell.textLabel?.text = "cell \(indexPath.row)"
    
    return cell
  }
}
