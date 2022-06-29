//
//  BLEConnectGateway.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Foundation
import Combine
import CoreBluetooth

protocol BLEConnectProtocol {
    init(publisher: PassthroughSubject<BLEConnectState, Never>)
    func connect(_ peripheral: BLEPeripheralGateway)
    func disconnect(_ peripheral: BLEPeripheralGateway)
}

class BLEConnectGateway: BLEConnectProtocol {

    private let bleManager: CBCentralManager
    private let bleDelegate: BLEConnectDelegate
    private let bleQueue = DispatchQueue(label: "ble.connect.queue")

    required init(publisher: PassthroughSubject<BLEConnectState, Never>) {
        self.bleDelegate = BLEConnectDelegate(publisher: publisher)
        self.bleManager = CBCentralManager(delegate: self.bleDelegate, queue: bleQueue)
    }
    
    func connect(_ peripheral: BLEPeripheralGateway) {
        let peripherals = bleManager.retrievePeripherals(withIdentifiers: [peripheral.target.identifier])
        if let target = peripherals.first {
            peripheral.replace(target: target)
            bleManager.connect(target)
        }
    }
    
    func disconnect(_ peripheral: BLEPeripheralGateway) {
        bleManager.cancelPeripheralConnection(peripheral.target)
    }
}
