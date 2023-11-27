//
//  SupportFunctions.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit
import CryptoKit

class SupportFunctions {
    func createSV(_ elements: [UIView], axis: NSLayoutConstraint.Axis = .vertical, align: UIStackView.Alignment = .center) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: elements)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = align
        return stackView
    }
    func createAmountLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func createDescriptionLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    func createButton(_ title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        let container = AttributeContainer([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        let attribString = AttributedString(title, attributes: container)
        config.attributedTitle = attribString
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func createButtonWithImage(_ image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func formateDataToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    func hashPassword(_ password: String) -> String {
        let salt = "sdfghWERHJdWE3@$%hjmSDFqedgj"
        let data = Data((salt + password).utf8)
        let hash = Data(SHA256.hash(data: data)).base64EncodedString()
        return hash
    }
    func setImageAsync(url: URL?, imageView: inout UIImageView) {
        guard let url = url else { return }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak imageView] data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView?.image = image
                    print("Image loaded successfully")
                }
            }
        }
        dataTask.resume()
    }
    func createDefaultUsers() -> [User] {
        var url: URL? = URL(string: "https://clck.ru/36N9D6")
        var passwordHash = self.hashPassword("Evaklq")
        var evaklq = User(icon: url,
            nick: "Evaklq", subr: 100,
            subt: 100, ema: nil, num: nil,
            pass: passwordHash, posts: [],
            des: "evaklq cat account",
            link: "https://t.me/evaklq")
        createPosts(8, &evaklq)

        url = URL(string: "https://clck.ru/36PZms")
        passwordHash = self.hashPassword("Itis")
        var itis = User(icon: url, nick: "Itis",
            subr: 100000, subt: 1,
            ema: nil, num: nil,
            pass: passwordHash, posts: [],
            des: "itis is the best",
            link: "https://t.me/evaklq")
        createPosts(5, &itis)

        url = URL(string: "https://clck.ru/36PZio")
        passwordHash = self.hashPassword("Fish cat")
        var fishCat = User(icon: url, nick: "Fish cat",
            subr: 890, subt: 0, ema: nil,
            num: nil, pass: passwordHash,
            posts: [], des: "do you sell fishes?",
            link: "https://t.me/evaklq")
        createPosts(6, &fishCat)
        return [evaklq, itis, fishCat]
    }
    func createPosts(_ amountOfPosts: Int, _ user: inout User) {
        var posts: [Post] = []
        var amount = amountOfPosts
        while amount != 0 {
            posts.append(createPost(with: user))
            amount -= 1
        }
        user.posts = posts
        user.amountOfPosts = posts.count
    }
    func createStories() -> [Story] {
        let stories: [Story] = [
            Story(icon: createImageCat("cat1")),
            Story(icon: createImageCat("cat2")),
            Story(icon: createImageCat("cat3")),
            Story(icon: createImageCat("cat4")),
            Story(icon: createImageCat("cat5")),
            Story(icon: createImageCat("cat6")),
            Story(icon: createImageCat("cat7"))
        ]
        return stories
    }
}

extension SupportFunctions {
    private func createImageCat(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
    private func createPost(with user: User) -> Post {
        let photos = createCatsImages()
        let descriptions = createCatsDescriptions()
        let post = Post(id: Int.random(in: 2...2753690),
            photos: photos[Int.random(in: 0...6)],
            iconUrl: user.iconUrl,
            nick: user.nick,
            date: randomDate(),
            comments: [], likes: Int.random(in: 0...100),
            description: descriptions[Int.random(in: 0...3)])
        return post
    }
    private func randomDate() -> Date {
        let randomOffset = Int.random(in: 1...7)
        let currentDate = Date()
        let pastDate = Calendar.current.date(byAdding: .day, value: -randomOffset, to: currentDate) ?? Date.now
        return pastDate
    }
    private func createCatsImages() -> [UIImage] {
        let photos = [
            createImageCat("cat1"),
            createImageCat("cat2"),
            createImageCat("cat3"),
            createImageCat("cat4"),
            createImageCat("cat5"),
            createImageCat("cat6"),
            createImageCat("cat7")
        ]
        return photos
    }
    private func createCatsDescriptions() -> [String] {
        let words = [
            "Супер кот лялялялялялял супер кот лялялялялял",
            "Мне очень нравится этот кот, он очень милый и хороший, я его люблю",
            "кааааайф",
            "мяу мяу мяу мяуямуя"
        ]
        return words
    }
}
