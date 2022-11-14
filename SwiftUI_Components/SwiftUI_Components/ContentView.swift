//
//  ContentView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "Components")
                List {
                    NavigationLink(
                        destination: WrapHStackExample(), label: {
                        Text("WrapHStackView")
                    })
                    
                    NavigationLink(
                        destination: QRCodeViewExample(), label: {
                        Text("QRCodeView")
                    })
                    
                    NavigationLink(
                        destination: QrCodeScannerViewExample(), label: {
                        Text("QrCodeScannerView")
                    })
                    
                    NavigationLink(
                        destination: StepBottomSheetViewExample(), label: {
                        Text("StepBottomSheetView")
                    })
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
