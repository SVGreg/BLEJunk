//
//  PeripheralItemView.swift
//  BLEJunk
//
//  Created by Sergii Tarasov on 16.06.2022.
//

import SwiftUI

struct PeripheralItemView: View {
    
    @State var item: ScannerViewModel.PeripheralItem
    @Binding var selectedItem: String?
    
    var body: some View {
        NavigationLink(tag: item.id, selection: $selectedItem, destination: {
            PeripheralInfoView(viewModel: PeripheralInfoViewModel(item: item))
        }, label: {
            HStack {
                
                Circle()
                    .foregroundColor(item.connectable ? .green : .red)
                    .frame(width: 8.0, height: 8.0)
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                    Text(item.id)
                        .font(.caption)
                }
                
                Spacer()
            }
            .frame(idealWidth: 320.0)
            .padding(.horizontal, 20.0)
            .background {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor(.blue)
            }
        })
        .buttonStyle(.plain)
        
        
    }
}

struct PeripheralItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ScannerViewModel.PeripheralItem(id: "43345", name: "My peripheral", connectable: false, data: nil)
        PeripheralItemView(item: item, selectedItem: .constant(nil))
    }
}
