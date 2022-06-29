//
//  ConnectService.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import CoreBluetooth
import Foundation

protocol ConnectServiceProtocol {
    init(context: ConnectContextProtocol)
    func connect(_ peripheral: BLEPeripheralGateway)
    func disconnect(_ peripheral: BLEPeripheralGateway)
}

class ConnectService: ConnectServiceProtocol {
    
    static let shared = ConnectService()
    
    private let context: ConnectContextProtocol
    private let gateway: BLEConnectProtocol
    
    required init(context: ConnectContextProtocol = ConnectContext.shared) {
        self.context = context
        gateway = BLEConnectGateway(publisher: context.connectState)
    }
    
    func connect(_ peripheral: BLEPeripheralGateway) {
        gateway.connect(peripheral)
    }
    
    func disconnect(_ peripheral: BLEPeripheralGateway) {
        gateway.disconnect(peripheral)
    }
}
