

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

    func generateInterval (due: Date) -> Double {
        var currentMonths: [Int] = []
        var dueMonths: [Int] = []
        var btwMonths: [Int] = []
        var dayCount: Double = 0
        let currentDate = Date()
        let dueDate = due
        let calendar = Calendar(identifier: .gregorian)
        let currentComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate)
        let dueComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dueDate)
        
        let secondsToHours = (currentComponents.second! / 60) / 60
        let minsToHours = currentComponents.minute! / 60
        let firstDayHours = 24 - (currentComponents.hour! + (secondsToHours + minsToHours))
        
        func firstMonth (index: Int) -> Double {
            return Double(((switchMonth(month: index) - currentComponents.day!) * 24) + firstDayHours) / Double(24)
        }
        
        func otherMonthsOfCurrentYear (index: Int) -> Double {
            return Double(switchMonth(month: index))
        }

        if dueComponents.year! == currentComponents.year! {
            for month in currentComponents.month!...dueComponents.month! {
                currentMonths.append(month)
            }
            for index in 0..<currentMonths.count {
                if index == 0 {
                    dayCount = firstMonth(index: currentMonths[index])
                } else if index == currentMonths.count - 1 {
                    dayCount += Double(dueComponents.day!)
                } else {
                    dayCount += otherMonthsOfCurrentYear(index: currentMonths[index])
                }
            }
        } else if dueComponents.year! > currentComponents.year! {
            for year in currentComponents.year!...dueComponents.year! {
                if year == currentComponents.year! {
                    for month in currentComponents.month!...12 {
                        currentMonths.append(month)
                    }
                    for index in 0..<currentMonths.count {
                        if index == 0 {
                            dayCount = firstMonth(index: currentMonths[index])
                        }else {
                            dayCount += Double(switchMonth(month: currentMonths[index]))
                        }
                    }
                }else if year == dueComponents.year! {
                    for month in 0..<dueComponents.month! {
                        dueMonths.append(month)
                    }
                    for index in dueMonths {
                        if index == dueMonths.count - 1 {
                            dayCount += Double(dueComponents.day!) + Double(((dueComponents.hour! + (dueComponents.second! + dueComponents.minute!)) / 24))
                        } else {
                            dayCount += Double(switchMonth(month: dueMonths[index]))
                        }
                    }
                }else {
                    for month in 1...12 {
                        btwMonths.append(month)
                    }
                    for index in btwMonths {
                        dayCount += Double(switchMonth(month: btwMonths[index - 1]))
                    }
                }
            }
        } else {
            print("Wrong year")
        }
        let secondsCount = dayCount * (60 * 60 * 24)
        
        return secondsCount
    }
}
