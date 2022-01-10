import UIKit

class CoinTableViewCell: UITableViewCell {
  static let reuseID = "CoinTableViewCell"
  
  var coin: Coin? {
    didSet {
      guard let coin = coin else {
        return
      }

      coinLabel.text = coin.name
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
    rowStack.spacing = 10
    
    coinLabel.translatesAutoresizingMaskIntoConstraints = false
    coinLabel.numberOfLines = 1
    coinStatusLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func layout() {
    addSubview(rowStack)
    rowStack.addArrangedSubview(coinLabel)
    rowStack.addArrangedSubview(coinStatusLabel)
    
    NSLayoutConstraint.activate([
      rowStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
    ])
  }
}
