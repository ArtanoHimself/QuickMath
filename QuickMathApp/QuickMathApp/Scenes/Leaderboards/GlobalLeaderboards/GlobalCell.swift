import UIKit

final class GlobalCell: UITableViewCell {
    
    lazy var playerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponentes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponentes() {
        backgroundColor = RGBColors.darkerViolet
        contentView.addSubview(playerInfoLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playerInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerInfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerInfoLabel.text = nil
    }
}
