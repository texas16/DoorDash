//
//  MonetaryField.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

struct MonetaryField: Codable {
    var currency: String
    var displayString: String
    var unitAmount: Double?
    var decimalPlaces: Int
    
    enum CodingKeys: String, CodingKey {
        case currency
        case displayString = "display_string"
        case unitAmount = "unit_amount"
        case decimalPlaces = "decimal_places"
    }
}
