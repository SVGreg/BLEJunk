//
//  PeripheralInfoView.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 17.06.2022.
//

import SwiftUI

struct PeripheralInfoView: View {
    
    @StateObject var viewModel: PeripheralInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                GroupBox {
                    HStack {
                        Text("Identifier").font(.headline)
                        Text(viewModel.item.id)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Date").font(.headline)
                        Text(viewModel.advDate)
                        Spacer()
                    }
                    HStack {
                        Text("Connectable").font(.headline)
                        Text(viewModel.advConnactable ? "true" : "false")
                            .foregroundColor(viewModel.advConnactable ? .green : .red)
                        Spacer()
                    }
                } label: {
                    Text("Advertisement")
                }
                
                GroupBox {
                    HStack(spacing: 20.0) {
                        Button {
                            viewModel.connect()
                        } label: {
                            Text("Connect")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(.accentColor)
                        }
                        
                        Button {
                            viewModel.disconnect()
                        } label: {
                            Text("Disconnect")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(.red)
                        }
                    }
                    
                    HStack {
                        Text("State").font(.headline)
                        Text(viewModel.isConnected ? "Connected" : "Disconnected")
                            .foregroundColor(viewModel.isConnected ? .green : .red)
                        Spacer()
                    }
                    
                    if let error = viewModel.errorText {
                        HStack {
                            Text("Error").font(.headline)
                            Text(error)
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                } label: {
                    Text("Connection")
                }
                
                DiscoveryView(viewModel: DiscoveryViewModel(item: viewModel.item), isConnected: $viewModel.isConnected)
            }
            
            Spacer()
        }
        .navigationTitle(viewModel.item.name)
    }
        
}

struct PeripheralDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ScannerViewModel.PeripheralItem(id: "43345", name: "My peripheral", connectable: true, data: nil)
        PeripheralInfoView(viewModel: PeripheralInfoViewModel(item: item))
    }
}
