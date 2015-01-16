//
//  PostTableViewCell.swift
//  mrkt-beta
//
//  Created by Andy Hadjigeorgiou on 1/12/15.
//  Copyright (c) 2015 vigme. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var body: UILabel!
    var id = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
