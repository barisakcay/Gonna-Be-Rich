//
//  GraphicCell.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 8.05.2024.
//

import UIKit

class GraphicCell: UICollectionViewCell {

    @IBOutlet weak var barView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(value: String, max: String, min: String) {
        barView.backgroundColor = .orange
        let graphViewHeight = (240 * (Float(max)! - Float(value)!)) / (Float(max)! - Float(min)!)
        let frame = CGRect(x: 0, y: 0, width: 13, height: Int(graphViewHeight) - 10)
        let graphView = UIView(frame: frame)
        graphView.backgroundColor = .systemBackground
        barView.addSubview(graphView)
    }
}
