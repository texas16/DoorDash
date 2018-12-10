//
//  ExploreTableViewCell.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDescription: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.storeImage.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
