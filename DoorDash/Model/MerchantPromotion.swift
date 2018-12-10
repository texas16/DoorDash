//
//  MerchantPromotion.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

struct MerchantPromotion: Codable {
    var id: Int
    var minimumSubtotalMonetaryFields: MonetaryField
    var deliveryFee: Double?
    var deliveryFeeMonetaryFields: MonetaryField
    var minimumSubtotal: Double?
    var newStoreCustomersOnly: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case minimumSubtotalMonetaryFields = "minimum_subtotal_monetary_fields"
        case deliveryFee = "delivery_fee"
        case deliveryFeeMonetaryFields = "delivery_fee_monetary_fields"
        case minimumSubtotal = "minimum_subtotal"
        case newStoreCustomersOnly = "new_store_customers_only"
    }
}
