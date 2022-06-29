//
//  ScannerContext.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import Combine
import Foundation

protocol ScannerContextProtocol {
    var peripherals: CurrentValueSubject<[BLEPeripheralGateway], Never> { get }
}

class ScannerContext: ScannerContextProtocol {
    static let shared = ScannerContext()
    
    let peripherals = CurrentValueSubject<[BLEPeripheralGateway], Never>([])
}
