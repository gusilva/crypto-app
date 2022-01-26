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
        
        guard let description = coinDetail.description, !description.isEmpty else {
          let emptyStateView = EmptyStateView(message: NSLocalizedString("EMPTY_STATE_COIN_DETAIL", comment: "empty state"))
          emptyStateView.frame = self.view.bounds
          
          self.view.addSubview(emptyStateView)
          
          return
        }
        self.coinDescriptionLabel.text = coinDetail.description
      }
    }
  }
  var teamMembers: [TeamMember] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  let titleLabel = UILabel()
  let rightLabel = UILabel()
  let coinDescriptionLabel = UILabel()
  let contentStackView = UIStackView()
  let tableView = UITableView()
  
  init(coinName: String, coinId: String) {
    super.init(nibName: nil, bundle: nil)
    titleLabel.text = coinName
    
    getCoinDetail(coinId: coinId)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    styles()
    layout()
    setupNavigationBar()
    configureTableView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    rightLabel.text = ""
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    guard let headerView = tableView.tableHeaderView else {return}
    let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    if headerView.frame.size.height != size.height {
      headerView.frame.size.height = size.height
      tableView.tableHeaderView = headerView
      tableView.layoutIfNeeded()
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
        self.teamMembers = coinDetail.team
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
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
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
    view.addSubview(tableView)
    
    contentStackView.addArrangedSubview(coinDescriptionLabel)
    tableView.tableHeaderView = contentStackView
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentStackView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
    ])
  }
  
  func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TeamMemberTableViewCell.self, forCellReuseIdentifier: TeamMemberTableViewCell.reuseIdentifier)
    tableView.bounces = false
    tableView.allowsSelection = false
    
    self.tableView.register(
      SectionHeaderView.self,
      forHeaderFooterViewReuseIdentifier:
        SectionHeaderView.reuseIdentifier
    )
  }
}


extension CoinDetailViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teamMembers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let teamMember = teamMembers[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: TeamMemberTableViewCell.reuseIdentifier, for: indexPath) as! TeamMemberTableViewCell
    cell.teamMember = teamMember
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as! SectionHeaderView
    header.titleLabel.text = NSLocalizedString("TEAM_MEMBERS_TITLE", comment: "team members")
    
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    teamMembers.count == 0 ? 0 : 48
  }
}
