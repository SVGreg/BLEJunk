//
//  ConnectContext.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Combine
import Foundation

protocol ConnectContextProtocol {
    var connectState: PassthroughSubject<BLEConnectState, Never> { get }
}

class ConnectContext: ConnectContextProtocol {
    static let shared = ConnectContext()
    
    let connectState = PassthroughSubject<BLEConnectState, Never>()
}
