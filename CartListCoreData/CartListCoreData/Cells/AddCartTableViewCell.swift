//
//  AddCartTableViewCell.swift
//  CartListCoreData
//
//  Created by Abul Kashem on 2/2/23.
//

import UIKit

class AddCartTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    func Configures(product: ShoppingModel) {
//        if let imagePath = product.image {
//            iconImage.sd_setImage(with: URL(string: imagePath))
//        }
//        //title.text = product.title
//    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
