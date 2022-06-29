//
//  DiscoveryContext.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import Combine
import Foundation

protocol DiscoveryContextProtocol {
    var discoveryState: PassthroughSubject<BLEDiscoveryState, Never> { get }
}

class DiscoveryContext: DiscoveryContextProtocol {
    static let shared = DiscoveryContext()
    
    let discoveryState = PassthroughSubject<BLEDiscoveryState, Never>()
}
