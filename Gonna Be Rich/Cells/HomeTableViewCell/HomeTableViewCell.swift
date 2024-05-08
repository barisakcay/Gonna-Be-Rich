//
//  HomeTableViewCell.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 6.05.2024.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var dailyChangeLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        contentView.layer.cornerRadius = 2
        contentView.clipsToBounds = true
    }
    
    public func configure(with model: safeCoins) {
        
        let iconString = model.iconUrl.replacingOccurrences(of: "svg", with: "png")
        guard let iconUrl = URL(string: iconString) else {return}
        coinImage.kf.setImage(
            with: iconUrl,
        placeholder: UIImage(systemName: "hourglass.circle.fill"))
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        let floatPrice = Float(model.price)!
        priceLabel.text = "$\(String(format: "%.3f", floatPrice))"
        let startingprice = Float(model.sparkline.first!)!
        let lastprice = Float(model.sparkline.last!)!
        let calculatedDailyChange = String(format: "%.3f", startingprice - lastprice)
        dailyChangeLabel.text = "\(model.change)% ($\(calculatedDailyChange))"
        if model.change.first == "-" {
            dailyChangeLabel.textColor = .red
        }else {
            dailyChangeLabel.textColor = .green
        }
        backView.layer.cornerRadius = 16
        backView.backgroundColor = .black.withAlphaComponent(0.06)
        backView.clipsToBounds = true
    }
}
