//
//  Double+Currency.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

extension Double {
    static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    public var currency: String? {
        return Double.currencyFormatter.string(from: self as NSNumber)
    }
}
