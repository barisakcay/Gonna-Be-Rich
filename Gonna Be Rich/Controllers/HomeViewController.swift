//
//  HomeViewController.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 3.05.2024.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    var coinManager = CoinManager()
    var coinsArr = [CoinModel]()
        
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.homeCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.homeCellIdentifier)
        coinManager.delegate = self
        coinManager.performRequest(with: Constants.url)
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeCellIdentifier, for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        cell.configure()
        return cell
    }
}

extension HomeViewController: CoinManagerDelegate {
    func getDatas(_ coinManager: CoinManager, coins: [Coins]) {
        print(coins[0].name)
        print(coins[1].name)
        print(coins[2].name)
        print(coins[3].name)
        
    }
}
