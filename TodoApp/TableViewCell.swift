//
//  TableViewCell.swift
//  TodoApp
//
//  Created by vlad on 29.03.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    let upcoming = "Upcoming"
    let done = "Done"
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var task: TaskModel? {
        didSet {
            cellConfig()
        }
    }
    
    func statusLableTextSet () {
        statusLabel.text = (task?.status)! ? done : upcoming
    }
    
    func setStatus () {
        task?.status = statusSwitch.isOn
    }
    
    @IBAction func statusSwitcherAction(_ sender: UISwitch) {
        setStatus()
        statusLableTextSet()
        statusSwitch.isOn = (task?.status)! ? true : false
    }
    
    func cellConfig () {
        taskNameLabel.text = task?.taskName
        descriptionTextView.text = task?.description
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 1
        statusLableTextSet()
        statusSwitch.onTintColor = UIColor.red
        statusSwitch.setOn((task?.status)!, animated: true)
        dateLabel.text = task?.dueDate
    }
  
}




