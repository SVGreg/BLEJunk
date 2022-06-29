//
//  BLEConnectDelegate.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Foundation
import Combine
import CoreBluetooth

class BLEConnectDelegate: NSObject, CBCentralManagerDelegate {
    private let publisher: PassthroughSubject<BLEConnectState, Never>
    
    init(publisher: PassthroughSubject<BLEConnectState, Never>) {
        self.publisher = publisher
        super.init()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("BLEConnect state: \(central.state.name)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        publisher.send(.connected(peripheral))
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        publisher.send(.disconnected(peripheral, error))
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        publisher.send(.error(peripheral, error))
    }
}
