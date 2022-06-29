//
//  BLEScannerDelegate.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import CoreBluetooth
import Foundation

class BLEScannerDelegate: NSObject, CBCentralManagerDelegate {
    private let onDiscover: ((BLEPeripheralGateway) -> ())
    
    init(_ onDiscover: @escaping (BLEPeripheralGateway) -> ()) {
        self.onDiscover = onDiscover
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("BLEScanner state: \(central.state.name)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let blePeripheral = BLEPeripheralGateway(peripheral: peripheral,
                                                 advertisement: advertisementData)
        onDiscover(blePeripheral)
    }
}

extension CBManagerState {
    var name: String {
        switch self {
        case .poweredOn: return "poweredOn"
        case .poweredOff: return "poweredOff"
        case .resetting: return "resetting"
        case .unauthorized: return "unauthorized"
        case .unsupported: return "unsupported"
        case .unknown: return "unknown"
        @unknown default:
            fatalError()
        }
    }
}
