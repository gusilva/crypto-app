import UIKit

class CoinDetailViewController: DataLoadingViewController {
  
  var coinDetail: CoinDetail? {
    didSet {
      guard let coinDetail = coinDetail else {
        return
      }

      DispatchQueue.main.async {
        self.rightLabel.text = coinDetail.isActive ? "active" : "not active"
        self.rightLabel.textColor = coinDetail.isActive ? .systemGreen : .systemRed
      }
    }
  }
  let titleLabel = UILabel()
  let rightLabel = UILabel()
  let headerStackView = UIStackView()
  
  init(coinName: String, coinId: String) {
    super.init(nibName: nil, bundle: nil)
    titleLabel.text = coinName
    
    getCoinDetail(coinId: coinId)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidDisappear(_ animated: Bool) {
    rightLabel.text = ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    if let navigationBar = self.navigationController?.navigationBar {
      rightLabel.translatesAutoresizingMaskIntoConstraints = false
      navigationBar.addSubview(rightLabel)
      navigationBar.topItem?.backButtonTitle = titleLabel.text

      NSLayoutConstraint.activate([
        rightLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
        rightLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16),
      ])
    }
  }
  
  
  private func getCoinDetail(coinId: String) {
    CoinService.shared.fetchCoinDetail(coinId: coinId) { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .success(let coinDetail):
        self.coinDetail = coinDetail
      case .failure(let error):
        print(error)
        break
      }
    }
  }
}
