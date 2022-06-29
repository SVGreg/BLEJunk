//
//  PeripheralInfoViewModel.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 18.06.2022.
//

import Combine
import Foundation

class PeripheralInfoViewModel: ObservableObject {
    
    @Published var item: ScannerViewModel.PeripheralItem
    
    @Published var advDate: String
    @Published var advConnactable: Bool
    
    @Published var isConnected: Bool = false
    @Published var errorText: String?
    
    private let connectContext: ConnectContextProtocol
    private let connectService: ConnectServiceProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(item: ScannerViewModel.PeripheralItem,
         connectContext: ConnectContextProtocol = ConnectContext.shared,
         discoveryContext: DiscoveryContextProtocol = DiscoveryContext.shared) {
        
        self.item = item
        self.connectContext = connectContext
        self.connectService = ConnectService(context: connectContext)
        
        if let adv = item.data?.advertisement {
            self.advDate = DateFormatter.localizedString(from: adv.date, dateStyle: .medium, timeStyle: .medium)
            self.advConnactable = adv.isConnectable
        } else {
            self.advDate = "--"
            self.advConnactable = false
        }
        
        self.connectContext.connectState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .unknown: break
                case .connected(let peripheral):
                    guard peripheral.identifier.uuidString == item.id else { return }
                    self.isConnected = true
                case .disconnected(let peripheral, let error):
                    guard peripheral.identifier.uuidString == item.id else { return }
                    self.isConnected = false
                    self.errorText = (error as? NSError)?.localizedDescription
                case .error(let peripheral, let error):
                    guard peripheral.identifier.uuidString == item.id else { return }
                    self.errorText = (error as? NSError)?.localizedDescription
                }
            }
            .store(in: &bag)
    }
    
    func connect() {
        guard let peripheral = item.data else {
            fatalError()
        }
        
        connectService.connect(peripheral)
    }
    
    func disconnect() {
        guard let peripheral = item.data else {
            fatalError()
        }
        
        connectService.disconnect(peripheral)
    }
}
