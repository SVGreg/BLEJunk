//
//  BLEDiscoveryState.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import CoreBluetooth

enum BLEDiscoveryState {
    case services(CBPeripheral, [CBService]?)
    case includedServices(CBService, [CBService]?)
    case characteristics(CBService, [CBCharacteristic]?)
    case descriptors(CBCharacteristic, [CBDescriptor]?)
}
