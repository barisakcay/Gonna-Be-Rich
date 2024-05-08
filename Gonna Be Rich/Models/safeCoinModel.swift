//
//  safeCoinModel.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 8.05.2024.
//

import Foundation

struct safeCoins: Codable {
    
    let symbol: String
    let name: String
    let iconUrl: String
    let marketCap: String
    let price: String
    let listedAt: Int
    let change: String
    let sparkline: [String]
    let volume: String
}
