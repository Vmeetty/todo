//
//  ViewController.swift
//  TodoApp
//
//  Created by vlad on 28.03.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    let cellID = "TableViewCell"
    let segueID = "AddViewController"
    
    var model: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultModelInit()
//        feedTableView.rowHeight = UITableViewAutomaticDimension // тут у меня не работает корректно. 
    }
    
    func defaultModelInit() {
        model.append(TaskModel(name: "GoIT courses, status", description: "In particular, when adding protocol conformance to a model, prefer adding a separate extension for the protocol methods.", dueDate: "15 / 06 / 2017"))
        model.append(TaskModel(name: "Meet my friends", description: "IThis keeps the related methods grouped together with the protocol and can simplify instructions to add a protocol to a class with its associated methods.", dueDate: "15 / 06 / 2017"))
        
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let addController = segue.destination as? AddViewController {
                addController.delegate = self
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell
        cell?.task = model[indexPath.row]
        
        return cell!
    }
}

extension ViewController: SaveDelegate {
    func save(_ task: TaskModel) {
        model.append(task)
        feedTableView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    
//    func sendNotify(_ seconds: Int) {
//        GenerateNotifies.sharedNotify?.schedulingNotify(inSeconds: 5, completion: { (success) in
//            if success {
//                print("Sended")
//            } else {
//                print("Failed")
//            }
//        })
//    }
    
}


