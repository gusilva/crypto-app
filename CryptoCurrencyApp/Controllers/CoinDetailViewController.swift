import UIKit

class CoinDetailViewController: UIViewController {
  
  var coinDetail: CoinDetail? {
    didSet {
      guard let coinDetail = coinDetail else {
        return
      }

      DispatchQueue.main.async {
        self.rightLabel.text = coinDetail.status
        self.rightLabel.textColor = coinDetail.isActive ? .systemGreen : .systemRed
        self.coinDescriptionLabel.text = coinDetail.description
      }
    }
  }
  let titleLabel = UILabel()
  let rightLabel = UILabel()
  let coinDescriptionLabel = UILabel()
  let contentStackView = UIStackView()
  let scrollView = UIScrollView()
  
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
    
    styles()
    layout()
    setupNavigationBar()
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

private extension CoinDetailViewController {
  func setupNavigationBar() {
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
  
  func styles() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.axis = .vertical
    contentStackView.alignment = .top
    contentStackView.distribution = .equalSpacing
    contentStackView.spacing = 10
    contentStackView.isLayoutMarginsRelativeArrangement = true
    contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)

    
    coinDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    coinDescriptionLabel.numberOfLines = 0
    coinDescriptionLabel.textAlignment = .justified
    coinDescriptionLabel.lineBreakMode = .byWordWrapping
  }
  
  func layout() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentStackView)
    contentStackView.addArrangedSubview(coinDescriptionLabel)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
}
