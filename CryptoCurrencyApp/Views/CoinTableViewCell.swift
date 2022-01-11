import UIKit

class CoinTableViewCell: UITableViewCell {
  static let reuseID = "CoinTableViewCell"
  
  var coin: Coin? {
    didSet {
      guard let coin = coin else {
        return
      }

      coinLabel.text = "\(coin.rank). \(coin.name) (\(coin.symbol))"
      coinStatusLabel.text = coin.isActive ? "active" : "not active"
      coinStatusLabel.textColor = coin.isActive ? .systemGreen : .systemRed
    }
  }
  let coinLabel = UILabel()
  let coinStatusLabel = UILabel()
  let rowStack = UIStackView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    styles()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CoinTableViewCell {
  func styles() {
    rowStack.translatesAutoresizingMaskIntoConstraints = false
    rowStack.axis = .horizontal
    rowStack.alignment = .fill
    rowStack.distribution = .fillProportionally
    rowStack.spacing = 10
    
    coinLabel.translatesAutoresizingMaskIntoConstraints = false
    coinLabel.numberOfLines = 1
    coinLabel.lineBreakMode = .byTruncatingTail
    
    
    coinStatusLabel.translatesAutoresizingMaskIntoConstraints = false
    coinStatusLabel.textAlignment = .center
  }
  
  func layout() {
    addSubview(rowStack)
    rowStack.addArrangedSubview(coinLabel)
    rowStack.addArrangedSubview(coinStatusLabel)
    
    NSLayoutConstraint.activate([
      rowStack.topAnchor.constraint(equalTo: self.topAnchor),
      rowStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      rowStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      rowStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      
      coinStatusLabel.widthAnchor.constraint(equalToConstant: 80)
    ])
  }
}
