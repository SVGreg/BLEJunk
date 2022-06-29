//
//  BLEPeripheralDelegate.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Combine
import CoreBluetooth
import Foundation

class BLEPeripheralDelegate: NSObject, CBPeripheralDelegate {
    private let publisher: PassthroughSubject<BLEDiscoveryState, Never>
    
    init(publisher: PassthroughSubject<BLEDiscoveryState, Never>) {
        self.publisher = publisher
        super.init()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        publisher.send(.services(peripheral, peripheral.services))
        peripheral.services?.forEach({ peripheral.discoverCharacteristics(nil, for: $0) })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        publisher.send(.characteristics(service, service.characteristics))
        service.characteristics?.forEach({ peripheral.discoverDescriptors(for: $0) })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        publisher.send(.descriptors(characteristic, characteristic.descriptors))
    }
}
