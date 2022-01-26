import UIKit

final class TeamMemberTableViewCell: UITableViewCell {
  static let reuseIdentifier: String = String(describing: self)
  
  var teamMember: TeamMember? {
    didSet {
      guard let teamMember = teamMember else {
        return
      }

      nameLabel.text = teamMember.name
      positionLabel.text = teamMember.position
    }
  }
  let nameLabel = UILabel()
  let positionLabel = UILabel()
  let stackView = UIStackView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    styles()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TeamMemberTableViewCell {
  func styles() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
//    stackView.alignment = .center
    stackView.distribution = .fill
//    stackView.spacing = 10
//    stackView.backgroundColor = .red
  }
  
  func layout() {
    addSubview(stackView)
    
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(positionLabel)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
    ])
  }
}
