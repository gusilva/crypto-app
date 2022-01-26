import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
  static let reuseIdentifier: String = String(describing: self)
  
  let titleLabel = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    styles()
    layout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

private extension SectionHeaderView {
  func styles() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = .gray
    titleLabel.font = .systemFont(ofSize: 25)
  }
  
  func layout() {
    contentView.addSubview(titleLabel)
    contentView.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
    ])
  }
  
}
