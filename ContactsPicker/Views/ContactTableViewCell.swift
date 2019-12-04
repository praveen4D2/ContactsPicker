//
//  ContactTableViewCell.swift
//  ContactsPicker
//
//  Created by Adaps on 04/12/19.
//  Copyright © 2019 CrazyTricks. All rights reserved.
//

import UIKit

class ContactTableViewCell: TableViewCell {

    /// Mark : -  XIB Outlets
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNum: UILabel!
    @IBOutlet weak var tickImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func configure(_ item: Any?) {
        
        guard let model = item as? Contact else { return  }
        self.lblName.text = model.name
        self.lblMobileNum.text = model.number
        
        if model.isSelected
        {
            self.tickImgView.image = UIImage(named: "checked")
        }
        else
        {
            self.tickImgView.image = UIImage(named: "unchecked")
        }
    }
    
}
