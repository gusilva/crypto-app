import UIKit

class CoinDetailViewController: UIViewController {
  
  let titleLabel = UILabel()
  let rightLabel = UILabel()
  let headerStackView = UIStackView()
  
  init(coinName: String, isActive: Bool) {
    super.init(nibName: nil, bundle: nil)
    titleLabel.text = coinName
    rightLabel.text = isActive ? "active" : "not active"
    rightLabel.textColor = isActive ? .systemGreen : .systemRed
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    if let navigationBar = self.navigationController?.navigationBar {
      rightLabel.translatesAutoresizingMaskIntoConstraints = false
      navigationBar.addSubview(rightLabel)
      navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
        title: titleLabel.text,
        style: .plain,
        target: nil,
        action: nil
      )


      NSLayoutConstraint.activate([
        rightLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
        rightLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16),
      ])
    }
    
//    self.navigationItem.backBarButtonItem?.title = ""
//    self.navigationController?.navigationItem.backButtonTitle = ""
//    self.navigationController?.navigationBar.topItem?.title = ""
    
//    self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(
//      title: "here",
//      style: .plain,
//      target: nil,
//      action: nil
//    )
  }
  
}
