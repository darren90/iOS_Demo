//
//  HomeMainCell.swift
//  ZhiHuPlus
//
//  Created by Fengtf on 16/2/18.
//  Copyright © 2016年 ftf. All rights reserved.
//

import UIKit
import SDWebImage

class HomeMainCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setModel(model:HomeModel){
        self.titleLabel.text = model.title;
        self.imgView.sd_setImageWithURL(NSURL(string: model.image), completed: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
