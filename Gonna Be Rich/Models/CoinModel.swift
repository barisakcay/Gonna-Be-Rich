//
//  CoinModel.swift
//  Gonna Be Rich
//
//  Created by Baris Akcay on 3.05.2024.
//

import Foundation

struct CoinModel: Codable {
    let data: CoinData
}

struct CoinData: Codable {
    let coins: [Coins]
}

struct Coins: Codable {
    
    let symbol: String?
    let name: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let listedAt: Int?
    let change: String?
    let sparkline: [String]?
    let volume: String?
    
    enum CodingKeys: String, CodingKey {
        case symbol, name, iconUrl, marketCap, price, listedAt, change, sparkline
        case volume = "24hVolume"
    }
}
