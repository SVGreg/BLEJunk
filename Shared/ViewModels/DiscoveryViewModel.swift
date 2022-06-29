//
//  DiscoveryViewModel.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import Combine
import Foundation
import CoreBluetooth
import SwiftUI

class DiscoveryViewModel: ObservableObject {

    @Published var item: ScannerViewModel.PeripheralItem
    
    @Published var services =  [CBUUID]()
    @Published var selectedService = ""
    
    @Published var characteristics = [String: [CBUUID]]()
    
    private let discoveryContext: DiscoveryContextProtocol
    private let discoveryService: DiscoveryServiceProtocol
 
    private var bag = Set<AnyCancellable>()
    
    init(item: ScannerViewModel.PeripheralItem,
         discoveryContext: DiscoveryContextProtocol = DiscoveryContext.shared) {
        
        self.item = item
        self.discoveryContext = discoveryContext
        self.discoveryService = DiscoveryService(context: discoveryContext)
        
        self.discoveryContext.discoveryState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .services(_, let services):
                    self.services = services?.compactMap({ $0.uuid }) ?? []
                    
                case .characteristics(let service, let characteristics):
                    self.characteristics[service.uuid.uuidString] =
                    characteristics?.compactMap({ $0.uuid })
                    
                case .descriptors(let characteristic, let descriptiors):
                    if let descriptiors = descriptiors {
                        print("        ---- Characteristic \(characteristic.uuid.debugDescription)")
                        descriptiors.forEach({ descriptor in
                            print("            ----> \(descriptor.uuid.debugDescription)")
                        })
                    }
                    
                default: break
                }
                
            }.store(in: &bag)
    }
    
    func discover() {
        guard let peripheral = item.data else {
            fatalError()
        }
        
        discoveryService.discover(peripheral)
    }
}

extension CBUUID: Identifiable {
    public var id: String {
        return uuidString
    }
}
