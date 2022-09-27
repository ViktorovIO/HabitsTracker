//
//  HabitViewController.swift
//  HabitsTracker
//
//  Created by Игорь Викторов on 27.09.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    var habitIdEdit: Int?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(colorButtonIsPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeText: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let time24Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "AccentColor")
        label.text = "11:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: "11:00")
        datePicker.date = date!
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        return datePicker
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.isHidden = true
        
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeModal))
        navigationItem.title = "Создать"
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(timeText)
        view.addSubview(time24Label)
        view.addSubview(timeDatePicker)
        view.addSubview(deleteButton)
        
        if let id = habitIdEdit {
            nameTextField.text = HabitsStore.shared.habits[id].name
            colorButton.backgroundColor = HabitsStore.shared.habits[id].color
            timeDatePicker.date = HabitsStore.shared.habits[id].date
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            time24Label.text = dateFormatter.string(from: timeDatePicker.date)
            deleteButton.isHidden = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timeText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            time24Label.topAnchor.constraint(equalTo: timeText.topAnchor),
            time24Label.leadingAnchor.constraint(equalTo: timeText.trailingAnchor),
            
            timeDatePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 7),
            timeDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
    }
    
    // Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "удалить привычку", message: "Удалить привычку \"\(HabitsStore.shared.habits[habitIdEdit!].name)\"?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { (action) -> Void in }
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) -> Void in
            HabitsStore.shared.habits.remove(at: self.habitIdEdit!)
            HabitsStore.shared.save()
            
            self.performSegue(withIdentifier: "backSegue", sender: self)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        time24Label.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func colorButtonIsPressed() {
        let pickerVC = UIColorPickerViewController()
        self.present(pickerVC, animated: true, completion: nil)
        pickerVC.selectedColor = colorButton.backgroundColor!
        
        pickerVC.delegate = self
    }
    
    @objc func closeModal() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveHabit() {
        let store = HabitsStore.shared
        
        if let id = habitIdEdit {
            store.habits[id].name = nameTextField.text ?? ""
            store.habits[id].date = timeDatePicker.date
            store.habits[id].color = colorButton.backgroundColor ?? .black
            
            if store.habits[id].name == "" {
                store.habits[id].name = "Просто привычка"
            }
        } else {
            let newHabit = Habit(name: nameTextField.text ?? "", date: timeDatePicker.date, color: colorButton.backgroundColor ?? .black)
            
            if newHabit.name == "" {
                newHabit.name = "Просто привычка"
            }
            
            store.habits.append(newHabit)
        }
        
        HabitsStore.shared.save()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
