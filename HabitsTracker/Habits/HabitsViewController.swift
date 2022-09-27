//
//  HabitsViewController.swift
//  HabitsTracker
//
//  Created by Игорь Викторов on 01.09.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private let progressCell = "progressCell"
    private let habitCell = "habitCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.backgroundColor = .systemGray5
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(HabitProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressCell)
        collectionView.register(HabitItemCollectionViewCell.self, forCellWithReuseIdentifier: habitCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        
        collectionView.reloadData()
    }
    
    @IBAction func unwindToHabitsViewController(segue: UIStoryboardSegue) {}
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCell, for: indexPath) as! HabitProgressCollectionViewCell
            
            cell.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
            cell.interestLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"
            
            return cell
        } else {
            let habit = HabitsStore.shared.habits[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCell, for: indexPath) as! HabitItemCollectionViewCell
            
            cell.nameLabel.text = habit.name
            cell.nameLabel.textColor = habit.color
            cell.checkButton.layer.borderColor = habit.color.cgColor
            cell.timeLabel.text = habit.dateString
            cell.countLabel.text = "Cчетчик: \(habit.trackDates.count)"
            
            if habit.isAlreadyTakenToday {
                cell.checkButton.backgroundColor = UIColor(cgColor: habit.color.cgColor)
                cell.checkButton.tintColor = UIColor(cgColor: habit.color.cgColor)
                cell.checkButton.setImage(.checkmark, for: .normal)
            } else {
                cell.checkButton.backgroundColor = .white
                cell.checkButton.tintColor = .white
                cell.checkButton.setImage(nil, for: .normal)
                
                cell.checkButton.tag = indexPath.row
                cell.checkButton.addTarget(self, action: #selector(buttonIsPressed(sender:)), for: .touchUpInside)
            }
            
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    @objc func buttonIsPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[sender.tag].color.cgColor)
        sender.tintColor = UIColor(cgColor: HabitsStore.shared.habits[sender.tag].color.cgColor)
        sender.setImage(.checkmark, for: .normal)
        
        if HabitsStore.shared.habits[sender.tag].isAlreadyTakenToday == false {
            HabitsStore.shared.track(HabitsStore.shared.habits[sender.tag])
        }
        
        collectionView.reloadData()
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: (collectionView.bounds.width - 32), height: 60)
        } else {
            return .init(width: (collectionView.bounds.width - 32), height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 12, right: 16)
        } else {
            return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let detailVC = self.storyboard?.instantiateViewController(identifier: "detail") as? HabitDetailsViewController else { return }
            
            detailVC.habitId = indexPath.row
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
