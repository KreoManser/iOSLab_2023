import UIKit;

/// Класс контроллера экрана калькулятора.
/// Он управляет пользовательским интерфейсом и логикой взаимодействия пользователя с калькулятором.
internal class CalculatorViewController: UIViewController {
    /// Отображает введенные пользователем числа и результаты операций.
    private lazy var displayLabel: UILabel = {
        let label = UILabel();
        label.text = "0";
        label.textAlignment = .right;
        label.font = UIFont.systemFont(ofSize: 170, weight: .thin);
        label.textColor = .white;
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.adjustsFontSizeToFitWidth = true;
        label.minimumScaleFactor = 0.5;
        label.numberOfLines = 1;
        label.lineBreakMode = .byTruncatingHead;
        
        return label;
    }()
    
    
    private var model = CalculatorModel(); // Представляет логику выполнения математических операций.
    private var shouldClearDisplay = true; //  Флаг, который указывает, нужно ли очистить метку отображения перед вводом новой цифры или оператора.
    private var decimalEntered = false; // Флаг, который указывает, была ли введена десятичная точка для ввода нецелых чисел.

    // Устанавливаем заголовки для кнопок (цифры и операции)
    private let buttonTitles: [String] = ["C", "+/−", "%", "÷",
                                          "7", "8", "9", "×",
                                          "4", "5", "6", "-",
                                          "1", "2", "3", "+",
                                          "0", "", ",", "="];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .black;
        setupUI();
    }
    
    /// Настраивает пользовательский интерфейс, включая (Label) отображения и кнопки.
    private func setupUI() {
        view.addSubview(displayLabel);

        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            displayLabel.heightAnchor.constraint(equalToConstant: 80)
        ]);
        
        // Добавление кнопок на экран
        let buttonSize: CGFloat = (view.bounds.width - 5 * 20) / 4, buttonSpacing: CGFloat = 20;
        for row in 0..<5 {
            for col in 0..<4 {
                let button = UIButton(type: .system);
                // Устанавливаем ширину кнопок
                var widthConstraint: NSLayoutConstraint!;
                button.setTitleColor(.white, for: .normal);
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24);

                if row == 0 && col < 3 {
                    // Меняем цвет кнопок первого ряда
                    button.backgroundColor = .systemGray3;
                    button.setTitleColor(.black, for: .normal);
                } else if col == 3 {
                    // Меняем цвет кнопок крайнего правого столбца
                    button.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0); // Оранжевый цвет
                } else {
                    // Цвет остальных кнопок
                    button.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0); // Тёмно-серый цвет
                }

                button.layer.cornerRadius = buttonSize / 2;
                button.translatesAutoresizingMaskIntoConstraints = false;
                view.addSubview(button);

                if (buttonTitles[row * 4 + col] == "0") {
                    // Делаем кнопку "0" шире
                    widthConstraint = button.widthAnchor.constraint(equalToConstant: buttonSize * 2 + buttonSpacing);
                    // Выравнивание "0" по левому краю
                    button.contentHorizontalAlignment = .left;
                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
                } else if (buttonTitles[row * 4 + col] == "") {
                    // Создаем пустое место для более широкой кнопки
                    widthConstraint = button.widthAnchor.constraint(equalToConstant: buttonSpacing);
                } else {
                    // Задаем ширину остальным кнопкам
                    widthConstraint = button.widthAnchor.constraint(equalToConstant: buttonSize);
                }

                NSLayoutConstraint.activate([
                    widthConstraint,
                    button.heightAnchor.constraint(equalToConstant: buttonSize),
                    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(col) * (buttonSize + buttonSpacing) + 20),
                    button.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: buttonSpacing + CGFloat(row) * (buttonSize + buttonSpacing))
                ]);

                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside);
            }
        }

        // Используем теги кнопок для соответствия заголовков
        var buttonIndex = 0;
        for subview in view.subviews {
            if let button = subview as? UIButton {
                button.setTitle(buttonTitles[buttonIndex], for: .normal);
                buttonIndex += 1;
            }
        }
    }

    /// Обработчик нажатия кнопок калькулятора.
    ///
    /// - Parameter sender: Кнопка, которая была нажата.
    @objc private func buttonTapped(_ sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if shouldClearDisplay {
                    displayLabel.text = title;
                    shouldClearDisplay = false;
                } else {
                    let currentText = displayLabel.text ?? "";
                    displayLabel.text = currentText + title;
                }
            case "+", "-", "×", "÷":
                decimalEntered = false;
                // Обработка нажатия операционной кнопки
                if let currentText = displayLabel.text, let currentValue = Double(currentText) {
                    model.setValue(currentValue);
                    shouldClearDisplay = true; // Очищаем экран
                    model.performOperation { (prevValue, currValue) in
                        switch title {
                        case "+":
                            return prevValue + currValue;
                        case "-":
                            return prevValue - currValue;
                        case "×":
                            return prevValue * currValue;
                        case "÷":
                            return prevValue / currValue;
                        default:
                            fatalError("Unknown operation");
                        }
                    }
                }
            case "%":
                if let currentText = displayLabel.text, let currentValue = Double(currentText) {
                    let percentageValue = currentValue / 100.0;
                    displayLabel.text = String(percentageValue);
                }
            case ",":
                if shouldClearDisplay {
                    displayLabel.text = "0.";
                    shouldClearDisplay = false;
                    decimalEntered = true;
                } else if !decimalEntered, let currentText = displayLabel.text {
                    displayLabel.text = currentText + ".";
                    decimalEntered = true;
                }
            case "+/−":
                if let currentText = displayLabel.text, var currentValue = Double(currentText) {
                    currentValue = -currentValue;
                    displayLabel.text = String(currentValue);
                }
            case "=":
                decimalEntered = false;
                if let currentText = displayLabel.text, let currentValue = Double(currentText) {
                    model.setValue(currentValue);
                }
                if let result = model.calculate() {
                    // Округляем только нецелые числа до 8 знаков после запятой
                    let roundedResult: String;
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        roundedResult = String(format: "%.0f", result);
                    } else {
                        roundedResult = String(format: "%.8f", result);
                    }
                    displayLabel.text = roundedResult;
                }
                shouldClearDisplay = true;
            case "C":
                decimalEntered = false;
                // Обработка нажатия кнопки "C" (сброс)
                model = CalculatorModel();
                displayLabel.text = "0";
                shouldClearDisplay = true;
            default:
                break;
            }
        }
    }
}
