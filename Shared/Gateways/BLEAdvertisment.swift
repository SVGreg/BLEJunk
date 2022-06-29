//
//  BLEAdvertisment.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Foundation

struct BLEAdvertisement {
    struct Key {
        static let timestamp = "kCBAdvDataTimestamp"
        static let manufacturerData = "kCBAdvDataManufacturerData"
        static let isConnectable = "kCBAdvDataIsConnectable"
        static let primaryPHY = "kCBAdvDataRxPrimaryPHY"
        static let secondaryPHY = "kCBAdvDataRxSecondaryPHY"
    }
    
    let date: Date
    let manufacturerData: Data
    let isConnectable: Bool
    let primaryPHY: Int
    let secondaryPHY: Int
    
    init?(_ raw: [String: Any]) {
        guard let timestamp = raw[Key.timestamp] as? TimeInterval,
              let manufacturerData = raw[Key.manufacturerData] as? Data,
              let isConnectable = raw[Key.isConnectable] as? Bool else {
            return nil
        }
        
        self.date = Date(timeIntervalSinceReferenceDate: timestamp)
        self.manufacturerData = manufacturerData
        self.isConnectable = isConnectable
        self.primaryPHY = (raw[Key.primaryPHY] as? Int) ?? 0
        self.secondaryPHY = (raw[Key.secondaryPHY] as? Int) ?? 0
    }
}
