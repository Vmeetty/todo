//
//  IntervalGenerating.swift
//  TodoApp
//
//  Created by vlad on 04.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class IntervalGenerating {
    
    let addVCObject = AddViewController()
    
    static var sharedInterval: IntervalGenerating?
    private init () {
    }
    
    func switchMonth (month: Int) -> Int {
        var daysInMonth = 0
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            daysInMonth = 31
        case 4, 6, 9, 11:
            daysInMonth = 30
        case 2:
            daysInMonth = 28
        default:
            break
        }
        return daysInMonth
    }

    func generateInterval () -> TimeInterval {
        var currentMonths: [Int] = []
        var dueMonths: [Int] = []
        var btwMonths: [Int] = []
        var dayCount = 0
        let currentDate = Date()
        let dueDate = self.addVCObject.datePicker.date
        let calendar = Calendar(identifier: .gregorian)
        let currentDay = calendar.component(.day, from: currentDate)
        let dueDay = calendar.component(.day, from: dueDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let dueMonth = calendar.component(.month, from: dueDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let dueYear = calendar.component(.year, from: dueDate)
  
        if dueYear == currentYear {
            for month in currentMonth...dueMonth {
                currentMonths.append(month)
            }
            for index in 0..<currentMonths.count {
                if index == 0 {
                    dayCount = switchMonth(month: currentMonths[index]) - currentDay
                } else if index == currentMonths.count - 1 {
                    dayCount += dueDay
                } else {
                    dayCount += switchMonth(month: currentMonths[index])
                }
            }
        } else if dueYear > currentYear {
            for year in currentYear...dueYear {
                if year == currentYear {
                    for month in currentMonth...12 {
                        currentMonths.append(month)
                    }
                    for index in 0..<currentMonths.count {
                        if index == 0 {
                            dayCount = switchMonth(month: currentMonths[index]) - currentDay
                        }else {
                            dayCount += switchMonth(month: currentMonths[index])
                        }
                    }
                }else if year == dueYear {
                    for month in 0..<dueMonth {
                        dueMonths.append(month)
                    }
                    for index in dueMonths {
                        if index == dueMonths.count - 1 {
                            dayCount += dueDay
                        } else {
                            dayCount += switchMonth(month: dueMonths[index])
                        }
                    }
                }else {
                    for month in 1...12 {
                        btwMonths.append(month)
                    }
                    for index in btwMonths {
                        dayCount += switchMonth(month: btwMonths[index - 1])
                    }
                }
            }
        } else {
            print("Wrong year")
        }

        let seconds = dayCount * (60 * 60 * 24)
        return TimeInterval(seconds)
    }
    
}
