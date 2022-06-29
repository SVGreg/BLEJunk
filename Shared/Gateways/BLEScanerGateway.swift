//
//  BLEScanerGateway.swift
//  BLEJunk (iOS)
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import Foundation
import CoreBluetooth

protocol BLEScannerProtocol {
    init(_ onDiscover: @escaping (BLEPeripheralGateway) -> ())
    func startScan()
    func stopScan()
}

class BLEScannerGateway: BLEScannerProtocol {
    
    private let bleManager: CBCentralManager
    private let bleDelegate: BLEScannerDelegate
    private let bleQueue = DispatchQueue(label: "ble.scanner.queue")

    required init(_ onDiscover: @escaping (BLEPeripheralGateway) -> ()) {
        self.bleDelegate = BLEScannerDelegate(onDiscover)
        self.bleManager = CBCentralManager(delegate: self.bleDelegate, queue: bleQueue)
    }
    
    func startScan() {
        bleManager.scanForPeripherals(withServices: nil)
    }
    
    func stopScan() {
        bleManager.stopScan()
    }
}
