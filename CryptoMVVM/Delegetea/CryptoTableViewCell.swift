//
//  CryptoTableViewCell.swift
//  CryptoMVVM
//
//  Created by Bircan Sezgin on 11.08.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var cryptoPrice: UILabel!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
    
    
// 1    public var item : CryptoModel!{
//        didSet{
//            self.cryptoNameLabel.text = item.currency
//            self.cryptoPrice.text = item.price
//        }
//    }

}
