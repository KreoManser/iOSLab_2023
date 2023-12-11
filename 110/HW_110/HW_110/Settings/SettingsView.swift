import UIKit

class SettingsView: UIView {
    lazy var table: UITableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        setUpTable()
    }
    func setUpTable() {
        addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.rowHeight = 60
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20),
            table.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            table.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}
