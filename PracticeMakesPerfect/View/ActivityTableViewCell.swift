import UIKit

class ActivityTableViewCell: UITableViewCell {
  static let identifier = "ActivityTableViewCell"

    let titleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let iconImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.clipsToBounds = false
      return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  private func applyConstraints() {
    let titlePosterUIImageViewConstraints = [
      iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
      iconImageView.widthAnchor.constraint(equalToConstant: 30),
      iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
    let titleLabelConstraints = [
      titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]

    NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
    NSLayoutConstraint.activate(titleLabelConstraints)
  }

    private func setup() {
      contentView.addSubview(titleLabel)
      contentView.addSubview(iconImageView)
      applyConstraints()
    }
}
