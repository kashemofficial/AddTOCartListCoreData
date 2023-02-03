//
//  ProductTableViewCell.swift
//  CartListCoreData
//
//  Created by Abul Kashem on 2/2/23.
//

import UIKit

protocol ProductView: AnyObject {
    func onTapAddCart(index: Int)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    var delegate : ProductView?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    
    func Configure(product: ShoppingModel) {
        if let imagePath = product.image {
            iconImage.sd_setImage(with: URL(string: imagePath))
        }
        title.text = product.title
    }
    
    @IBAction func buttonAddToAction(_ sender: UIButton) {
        delegate?.onTapAddCart(index: sender.tag)
    }
    
    
}
