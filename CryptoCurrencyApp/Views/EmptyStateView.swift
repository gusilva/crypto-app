import UIKit

class EmptyStateView: UIView {
  let messageLabel = TitleLabel(textAlignment: .center, fontSize: 28)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(messageLabel)
    
    configureMessageLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(message: String) {
    self.init(frame: .zero)
    
    messageLabel.text = message
  }
  
  private func configureMessageLabel() {
    
    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel
    
    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
}
