//
//  Date+Extension.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 26.02.2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
