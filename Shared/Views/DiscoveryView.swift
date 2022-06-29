//
//  DiscoveryView.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 19.06.2022.
//

import SwiftUI

struct DiscoveryView: View {
    
    @StateObject var viewModel: DiscoveryViewModel
    @Binding var isConnected: Bool
    
    var body: some View {
        Form {
            if isConnected {
                GroupBox {
                    HStack {
                        Spacer()
                        Button {
                            viewModel.discover()
                        } label: {
                            Text("Discover")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(.green)
                        }
                        Spacer()
                    }
                    
                    if viewModel.services.count > 0 {
                        GroupBox {
                            VStack(alignment: .leading) {
                                Picker("Services", selection: $viewModel.selectedService) {
                                    ForEach(viewModel.services) { service in
                                        Text(service.debugDescription)
                                            .font(.headline)
                                            .tag(service.uuidString)
                                    }
                                }
                                if let service = viewModel.selectedService,
                                   let chars = viewModel.characteristics[service], chars.count > 0 {
                                    GroupBox {
                                        VStack(alignment: .leading) {
                                            ForEach(chars) { char in
                                                HStack {
                                                    Text("‣")
                                                    Text(char.debugDescription)
                                                    Spacer()
                                                }
                                            }
                                        }
                                    } label: {
                                        Text("Characteristics")
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Text("Discovery")
                }
            }
        }
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ScannerViewModel.PeripheralItem(id: "43345", name: "My peripheral", connectable: false, data: nil)
        DiscoveryView(viewModel: DiscoveryViewModel(item: item), isConnected: .constant(true))
    }
}
