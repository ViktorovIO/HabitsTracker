//
//  InfoViewController.swift
//  HabitsTracker
//
//  Created by Игорь Викторов on 01.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let infoScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    
    private let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let infoHeaderLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        
        label.text = "Привычка за 21 день"
        
        return label
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(infoView)
        
        infoView.addSubview(infoHeaderLabel)
        infoView.addSubview(infoLabel)
        
        addTextInLabel()
        
        
        let constraints = [
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            infoScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            infoScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            infoView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            infoView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor),
            
            infoHeaderLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 22),
            infoHeaderLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: infoHeaderLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func addTextInLabel() {
        infoLabel.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n"
        
        infoLabel.text?.append("1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n")
        infoLabel.text?.append("2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n")
        infoLabel.text?.append("3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n\n")
        infoLabel.text?.append("4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n")
        infoLabel.text?.append("5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n")
        infoLabel.text?.append("6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.")
    }

}
