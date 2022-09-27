//
//  HabitDetailsViewController.swift
//  HabitsTracker
//
//  Created by Игорь Викторов on 27.09.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let cellId = "cellId"
    
    let detailTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    var habitId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray2
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(detailTableView)
        
        detailTableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: cellId)
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = habitId {
            title = HabitsStore.shared.habits[id].name
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController {
            if let historyVC = navVC.viewControllers[0] as? HabitViewController {
                historyVC.habitIdEdit = habitId
            }
        }
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! HabitDetailsTableViewCell
        
        let habit = HabitsStore.shared.habits[habitId ?? 0]
        let habitDate = HabitsStore.shared.dates[indexPath.row]
        
        if HabitsStore.shared.habit(habit, isTrackedIn: habitDate) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.selectionStyle = .none
        cell.dayLabel.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}
