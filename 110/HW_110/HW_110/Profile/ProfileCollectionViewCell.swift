import UIKit
class ProfileCollectionViewCell: UICollectionViewCell {
    lazy var cellImageView: UIImageView = {
        let cellImageView = UIImageView()
        return cellImageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpCellImageView()
    }
    private func setUpCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.clipsToBounds = true
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            cellImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    func configure(with photo: Photo) {
        cellImageView.image = UIImage()
    }
}
