//
//  CoinManager.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 8.05.2024.
//

import Foundation

protocol CoinManagerDelegate {
    func getDatas(_ coinManager: CoinManager, coins: [Coins])
}

struct CoinManager {
    
    var fetchedCoins = [Coins]()
    var delegate: CoinManagerDelegate?
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let safeData = data {
                if let coins = self.parseJSON(safeData) {
                    self.delegate?.getDatas(self, coins: coins)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ coinData: Data) -> [Coins]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            return decodedData.data.coins
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
