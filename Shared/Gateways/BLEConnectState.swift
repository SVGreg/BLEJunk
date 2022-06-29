//
//  BLEConnectState.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import CoreBluetooth

enum BLEConnectState {
    case unknown
    case connected(CBPeripheral)
    case disconnected(CBPeripheral, Error?)
    case error(CBPeripheral, Error?)
}
