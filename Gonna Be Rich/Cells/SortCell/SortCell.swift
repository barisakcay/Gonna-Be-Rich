//
//  SortCell.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 8.05.2024.
//

import UIKit

class SortCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var sortTypeLabel: UILabel!
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
    
    public func configure(with sortType: String) {
        sortTypeLabel.text = sortType
        backView.layer.cornerRadius = 16
        backView.backgroundColor = .black.withAlphaComponent(0.06)
        backView.clipsToBounds = true
        if sortType.last == "▲" {
            backView.backgroundColor = .orange.withAlphaComponent(0.3)
        }
        else {
            backView.backgroundColor = .orange.withAlphaComponent(0.7)
        }
    }
}
