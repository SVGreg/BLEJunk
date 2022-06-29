//
//  ScannerService.swift
//  BLEJunk (iOS)
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import Foundation

protocol ScannerServiceProtocol {
    func configure()
    func startScan()
    func stopScan()
}

class ScanerService: ScannerServiceProtocol {
    private let context: ScannerContextProtocol
    private var gateway: BLEScannerProtocol?
    
    private var peripherals = Set<BLEPeripheralGateway>()
    
    init(context: ScannerContextProtocol = ScannerContext.shared) {
        self.context = context
    }
    
    func configure() {
        gateway = BLEScannerGateway({[weak self] peripheral in
            guard let self = self else { return }
            
            self.peripherals.insert(peripheral)
            
            self.context.peripherals.send(Array(self.peripherals))
        })
    }
    
    func startScan() {
        precondition(gateway != nil)
        gateway?.startScan()
    }
    
    func stopScan() {
        gateway?.stopScan()
    }
}
