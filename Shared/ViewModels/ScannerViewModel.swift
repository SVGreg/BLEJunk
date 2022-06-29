//
//  ScannerViewModel.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import Combine
import Foundation
import CoreBluetooth

class ScannerViewModel: ObservableObject {
    
    struct PeripheralItem: Identifiable {
        let id: String
        let name: String
        let connectable: Bool
        
        let data: BLEPeripheralGateway?
    }
    
    @Published var peripherals = [PeripheralItem]()
    
    private let service: ScannerServiceProtocol
    private let context: ScannerContextProtocol
    private var bag = Set<AnyCancellable>()
    
    init(context: ScannerContextProtocol = ScannerContext.shared) {
        self.service = ScanerService(context: context)
        self.context = context
        
        context.peripherals.receive(on: RunLoop.main).sink { [weak self] blePeripherals in
            guard let self = self else { return }
            
            self.peripherals = blePeripherals.compactMap({
                
                return PeripheralItem(id: $0.target.identifier.uuidString,
                                      name: $0.target.name ?? "*noname",
                                      connectable: $0.advertisement?.isConnectable ?? false,
                                      data: $0)
            }).sorted(by: { $0.name > $1.name })
        }.store(in: &bag)
        
        service.configure()
    }
    
    func startScan() {
        service.startScan()
    }
    
    func stopScan() {
        service.stopScan()
    }
}
