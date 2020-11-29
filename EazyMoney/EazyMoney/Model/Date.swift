//
//  Date.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import Foundation

import Foundation

extension Date {

    func adding(months: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)

        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.month = months

        return calendar.date(byAdding: components, to: self)
    }

}
