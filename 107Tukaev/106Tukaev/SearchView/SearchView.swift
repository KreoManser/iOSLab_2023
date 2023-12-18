//
//  SearchView.swift
//  107Tukaev
//
//  Created by surexnx on 11.12.2023.
//

import UIKit

class SearchView: UIView, UICollectionViewDelegate {

    var controller: SearchViewController?
    private var textFieldDelegate: UITextFieldDelegate?
    var inputResolution: Bool = false

    private lazy var searchTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Поиск"
        textField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let colleсtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        colleсtionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentificator)
        colleсtionView.delegate = self
        colleсtionView.translatesAutoresizingMaskIntoConstraints = false
        return colleсtionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTapGestureRecognizer()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDataSource(_ dataSource: SearchDataSource) {
        collectionView.dataSource = dataSource
    }

    func reloadData() {
        collectionView.reloadData()
    }

    private func setupLayout() {
        addSubview(searchTextField)
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    var textChangeHandler: ((String) -> Void)?

    @objc private func textFieldHandler(_ textField: UITextField) {
        if let text = textField.text {
            textChangeHandler?(text)
        } else {
            textChangeHandler?("")
        }
    }

    func addTarger() {
        if !inputResolution {
            searchTextField.addTarget(self, action: #selector(textFieldHandler(_:)), for: .editingChanged)
            inputResolution = true
        }
    }

    func removeTarger() {
        if inputResolution {
            searchTextField.removeTarget(self, action: #selector(textFieldHandler(_:)), for: .editingChanged)
            inputResolution = false
        }
    }
    func setupTextFieldDelegate(delegate: UITextFieldDelegate) {
        searchTextField.delegate = delegate
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
        }

    @objc private func handleTapGesture() {
        endEditing(true)
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension SearchView: CellTapDelegate {
    func cellDidSelect(user: User) {
        removeTarger()
        handleTapGesture()
        controller?.navigationController?.pushViewController(FriendsViewController(user: user), animated: false)
    }
}
