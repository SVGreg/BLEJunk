//
//  DiscoveryService.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import Combine
import Foundation

protocol DiscoveryServiceProtocol {
    func discover(_ peripheral: BLEPeripheralGateway)
}

class DiscoveryService: DiscoveryServiceProtocol {
    
    static let shared = DiscoveryService()
    
    private let context: DiscoveryContextProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(context: DiscoveryContextProtocol = DiscoveryContext.shared) {
        self.context = context
    }
    
    func discover(_ peripheral: BLEPeripheralGateway) {
        peripheral.publisher.sink { [weak self] state in
            guard let self = self else { return }
            self.context.discoveryState.send(state)
        }.store(in: &bag)
        
        peripheral.target.discoverServices(nil)
    }
}
