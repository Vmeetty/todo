//
//  CellModel.swift
//  TodoApp
//
//  Created by vlad on 29.03.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation

class TaskModel {
    
    var taskName: String
    var description: String
    var status = false
    var dueDate: String
    
    init(name: String, description: String, dueDate: String) {
        taskName = name
        self.description = description
        self.dueDate = dueDate
    }
    
}
