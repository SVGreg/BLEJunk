//
//  BLEPeripheralGateway.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import Combine
import CoreBluetooth
import Foundation

class BLEPeripheralGateway {
    private(set) var target: CBPeripheral
    let advertisementRaw: [String: Any]
    let advertisement: BLEAdvertisement?
    
    let publisher = PassthroughSubject<BLEDiscoveryState, Never>()
    
    private lazy var delegate = BLEPeripheralDelegate(publisher: publisher)
    
    init(peripheral: CBPeripheral, advertisement: [String : Any] = [:]) {
        self.target = peripheral
        self.advertisementRaw = advertisement
        self.advertisement = BLEAdvertisement(advertisement)
        peripheral.delegate = delegate
    }
    
    func replace(target: CBPeripheral) {
        self.target.delegate = nil
        self.target = target
        self.target.delegate = delegate
    }
}

extension BLEPeripheralGateway: Hashable {
    static func == (lhs: BLEPeripheralGateway, rhs: BLEPeripheralGateway) -> Bool {
        return lhs.target.identifier == rhs.target.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(target.identifier.hashValue)
    }
}
