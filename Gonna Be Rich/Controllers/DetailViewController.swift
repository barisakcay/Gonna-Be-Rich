//
//  DetailViewController.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 3.05.2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var coinTransfer = [safeCoins]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var dailyMaxLabel: UILabel!
    @IBOutlet weak var dailyMinLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.graphicCellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constants.graphicCellIdentifier)
        configure()
    }
    
    private func configure() {
        
        let detailedCoin = coinTransfer.first!
        nameLabel.text = detailedCoin.name
        let iconString = (detailedCoin.iconUrl.replacingOccurrences(of: "svg", with: "png"))
        let iconUrl = URL(string: iconString)
        coinImage.kf.setImage(with: iconUrl)
        let floatPrice = Float(detailedCoin.price)
        priceLabel.text = "$\(String(format: "%.3f", floatPrice!))"
        dailyMaxLabel.text = "Highest Price:\n\(String(format: "%.3f", Float(detailedCoin.sparkline.max()!)!))"
        dailyMinLabel.text = "Lowest Price:\n\(String(format: "%.3f", Float(detailedCoin.sparkline.min()!)!))"
        let startingprice = Float(detailedCoin.sparkline.first!)!
        let lastprice = Float(detailedCoin.sparkline.last!)!
        let calculatedDailyChange = String(format: "%.3f", startingprice - lastprice)
        changeLabel.text = "Daily Change:\n\(detailedCoin.change)% ($\(calculatedDailyChange))"
        if detailedCoin.change.first == "-" {
            changeLabel.textColor = .red.withAlphaComponent(0.7)
        }else {
            changeLabel.textColor = .green.withAlphaComponent(0.7)
        }
        volumeLabel.text = "Volume:\n\(detailedCoin.volume)"
        navigationItem.title = detailedCoin.symbol
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.graphicCellIdentifier, for: indexPath) as? GraphicCell else { return UICollectionViewCell()}
        let detailedCoin = coinTransfer.first!
        cell.configure(value: detailedCoin.sparkline[indexPath.row], max: detailedCoin.sparkline.max()! , min: detailedCoin.sparkline.min()!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 13, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}
