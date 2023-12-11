import UIKit
class StoriesCollectionViewCell: UICollectionViewCell {
    lazy var storiesImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var backStoriesImage: UIImageView = {
        let imageView = UIImageView(image: round(image: .gradient))
        return imageView
    }()
    lazy var subTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpBackStoriesImage()
        setUpStoriesImageView()
        setUpSubTitle()
    }
    private func setUpStoriesImageView() {
        contentView.addSubview(storiesImageView)
        storiesImageView.translatesAutoresizingMaskIntoConstraints = false
        storiesImageView.layer.cornerRadius = 32
        storiesImageView.contentMode = .scaleAspectFill
        storiesImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            storiesImageView.centerXAnchor.constraint(equalTo: backStoriesImage.centerXAnchor),
            storiesImageView.centerYAnchor.constraint(equalTo: backStoriesImage.centerYAnchor),
            storiesImageView.widthAnchor.constraint(equalTo: backStoriesImage.widthAnchor, constant: -7),
            storiesImageView.heightAnchor.constraint(equalTo: backStoriesImage.heightAnchor, constant: -7)
        ])
    }
    private func setUpBackStoriesImage() {
        contentView.addSubview(backStoriesImage)
        backStoriesImage.contentMode = .scaleAspectFill
        backStoriesImage.clipsToBounds = true
        backStoriesImage.layer.borderWidth = 0.5
        backStoriesImage.layer.cornerRadius = 32
        backStoriesImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backStoriesImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backStoriesImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backStoriesImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            backStoriesImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55)
        ])
    }
    private func setUpSubTitle() {
        contentView.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.text = "Ваша история"
        subTitle.textColor = .white
        subTitle.font = UIFont.systemFont(ofSize: 12)
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: storiesImageView.bottomAnchor, constant: 2),
            subTitle.leadingAnchor.constraint(equalTo: storiesImageView.leadingAnchor, constant: 7),
            subTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            subTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    func round(image: UIImage) -> UIImage {
        let imageWidth = image.size.width
        let imageHeight = image.size.height

        let diameter = min(imageWidth, imageHeight)
        let isLandscape = imageWidth > imageHeight

        let xOffset = isLandscape ? (imageWidth - diameter) / 2 : 0
        let yOffset = isLandscape ? 0 : (imageHeight - diameter) / 2

        let imageSize = CGSize(width: diameter, height: diameter)

        return UIGraphicsImageRenderer(size: imageSize).image { _ in

            let ovalPath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: imageSize))
            ovalPath.addClip()
            image.draw(at: CGPoint(x: -xOffset, y: -yOffset))
            UIColor.white.setStroke()
            ovalPath.lineWidth = diameter / 50
            ovalPath.stroke()
        }
    }
    func configure(with photo: Photo) {
        storiesImageView.image = round(image: UIImage())
//        subTitle.text = photo.author
    }
}
