//
//  HomeTableViewCell.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 6.05.2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var dailyChangeLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configure() {
        coinImage.image = UIImage(systemName: "dollarsign")
        symbolLabel.text = "USD"
        nameLabel.text = "American Dollars"
        priceLabel.text = "32.28"
        dailyChangeLabel.text = "-0.06"
        dailyChangeLabel.textColor = .red
    }
}
