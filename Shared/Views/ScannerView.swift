//
//  ScannerView.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 15.06.2022.
//

import SwiftUI

struct ScannerView: View {
    
    @StateObject var viewModel = ScannerViewModel()
    @State var selectedItem: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.peripherals) { item in
                            PeripheralItemView(item: item, selectedItem: $selectedItem)
                        }
                    }
                }
                .padding()
                
                HStack(spacing: 20.0) {
                    Button {
                        viewModel.startScan()
                    } label: {
                        Text("Start Scan")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8.0)
                            .foregroundColor(.accentColor)
                    }
                    
                    Button {
                        viewModel.stopScan()
                    } label: {
                        Text("Stop Scan")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8.0)
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Scanner")
        .navigationViewStyle(.columns)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
