//
//  Store.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

struct Store: Codable {
    var id: Int
    var isTimeSurging: Bool
    var maxOrderSize: Int?
    var deliveryFee: Double
    var merchantPromotions: [MerchantPromotion]
    var averageRating: Double
    var compositeScore: Int
    var statusType: String
    var isOnlyCatering: Bool
    var status: String
    var description: String
    var business: Business
    var tags: [String]
    var asapTime: Int?
    var extraSosDeliveryFee: Double
    var coverImgUrl: String
    var headerImgUrl: String
    var address: Address
    var priceRange: Int
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case isTimeSurging = "is_time_surging"
        case maxOrderSize = "max_order_size"
        case deliveryFee = "delivery_fee"
        case merchantPromotions = "merchant_promotions"
        case averageRating = "average_rating"
        case compositeScore = "composite_score"
        case statusType = "status_type"
        case isOnlyCatering = "is_only_catering"
        case status
        case description
        case business
        case tags
        case asapTime = "asap_time"
        case extraSosDeliveryFee = "extra_sos_delivery_fee"
        case coverImgUrl = "cover_img_url"
        case headerImgUrl = "header_img_url"
        case address
        case priceRange = "price_range"
        case name
        case url
    }
}
