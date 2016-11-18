//
//  MenuItemTableViewCell.swift
//  HopOn
//
//  Created by ROHIT SARAF on 18/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        print(itemImageView)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItemImage(imageName : String?) {
        if imageName == nil || imageName == "" {
            return
        }
        itemImageView.image = UIImage.init(named: imageName!)
    }

}
