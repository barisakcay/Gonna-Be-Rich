//
//  HomeViewController.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 3.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var coinManager = CoinManager()
    var coinsArr = [safeCoins]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var rankingListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var sortTypeButton: UIButton!
    @IBOutlet weak var sortButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Gonna Be Rich"
        let nib = UINib(nibName: Constants.homeCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.homeCellIdentifier)
        coinManager.delegate = self
        coinManager.performRequest(with: Constants.url)
        sortTypeButton.tintColor = .orange.withAlphaComponent(0.9)
        sortTypeButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sortVC = storyboard.instantiateViewController(withIdentifier: Constants.sortViewControllerIdentifier) as! SortViewController
        if let presentationController = sortVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        sortVC.delegate = self
        self.present(sortVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeCellIdentifier, for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        cell.configure(with: coinsArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.detailViewControllerIdentifier) as! DetailViewController
        detailVC.coinTransfer = [coinsArr[indexPath.row]]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: CoinManagerDelegate {
    func getDatas(_ coinManager: CoinManager, coins: [Coins]) {
        for i in 0...coins.count - 1 {
            guard let symbol = coins[i].symbol,
                  let name = coins[i].name,
                  let iconUrl = coins[i].iconUrl,
                  let marketCap = coins[i].marketCap,
                  let price = coins[i].price,
                  let listedAt = coins[i].listedAt,
                  let change = coins[i].change,
                  let sparkline = coins[i].sparkline,
                  let volume = coins[i].volume else {return}
            let newCoin = safeCoins(symbol: symbol, name: name, iconUrl: iconUrl, marketCap: marketCap, price: price, listedAt: listedAt, change: change, sparkline: sparkline, volume: volume)
            coinsArr.append(newCoin)
        }
    }
}

extension HomeViewController: SortTypeDelegate {
    func sendType(_ text: String) {
        sortTypeButton.setTitle(text, for: .normal)
        sortTypeButton.titleLabel?.font = UIFont(name: "System Bold", size: 16)
        
        switch text {
        case "Price ▼":
            coinsArr.sort { Float($0.price)! > Float($1.price)! }
        case "Price ▲":
            coinsArr.sort { Float($0.price)! < Float($1.price)! }
        case "Market Cap ▼":
            coinsArr.sort { $0.marketCap > $1.marketCap }
        case "Market Cap ▲":
            coinsArr.sort { $0.marketCap < $1.marketCap }
        case "24h Volume ▼":
            coinsArr.sort { $0.volume > $1.volume }
        case "24h Volume ▲":
            coinsArr.sort { $0.volume < $1.volume }
        case "Change ▼":
            coinsArr.sort { Float($0.change)! > Float($1.change)! }
        case "Change ▲":
            coinsArr.sort { Float($0.change)! < Float($1.change)! }
        default:
            coinsArr.sort { $0.price > $1.price }
        }
        tableView.reloadData()
    }
}
