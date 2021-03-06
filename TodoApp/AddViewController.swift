//
//  AddViewController.swift
//  TodoApp
//
//  Created by vlad on 29.03.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

protocol SaveDelegate {
    func save (_ task:TaskModel)
}

class AddViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    var placeholderLabel : UILabel?
    
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    let notifyTitle = "My app"
    let notifyBody = "It's time to check your tasks"
    let notifyID = "myNotify"
    
    var delegate: SaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
       
        // реализация placeholder в textView
        descriptionTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel?.text = "Enter some text..."
        placeholderLabel?.font = UIFont.italicSystemFont(ofSize: (descriptionTextView.font?.pointSize)!)
        placeholderLabel?.sizeToFit()
        descriptionTextView.addSubview(placeholderLabel!)
        placeholderLabel?.frame.origin = CGPoint(x: 0, y: 5)
        placeholderLabel?.textColor = UIColor.lightGray
        placeholderLabel?.isHidden = !descriptionTextView.text.isEmpty
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handelTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - For GestureRecognizer
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel?.text = nil
    }
    func handelTap () {
        view.endEditing(true)
    }
    
    // MARK: - create datePicker
    func createDatePicker () {
        // toolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // bar button item
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([barButton], animated: false)
        dateTextField.inputAccessoryView = toolBar
        
        // assigning datepicker to the textFied4
        dateTextField.inputView = datePicker
    }
    
    func donePressed () {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // MARK: - save action and scheduling local notification
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
//        let center = NotificationCenter.default
//        center.post(name: NSNotification.Name(rawValue: "myNotify"), object: self, userInfo: ["Hello!":"Huh!"])
        
        if let wroteTaskName = taskNameTextField.text, let wroteDescription = descriptionTextView.text, let setDueDate = dateTextField.text {
            let task = TaskModel(name: wroteTaskName, description: wroteDescription, dueDate: setDueDate)
            let seconds = IntervalGenerating.sharedInterval?.generateInterval(due: datePicker.date)
            GenerateNotifies.sharedNotify?.schedulingNotify(inSeconds: seconds!, completion: { (success) in
                if success {
                    print("Sended")
                } else {
                    print("Failed")
                }
            })
            delegate?.save(task)
        }
    }
    
}


