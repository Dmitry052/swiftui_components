//
//  QrCodeScannerViewExample.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import Foundation
import SwiftUI

final class QrCodeScannerViewModelExample: ObservableObject {
    @Published var value = ""
    @Published var visibalQrScanner = false
    
    func onFoundQrCode(_ value: String) {
        DispatchQueue.main.async {
            self.value = value
            self.visibalQrScanner = false
        }
    }
    
    func onPressShowScanner() {
        visibalQrScanner = true
    }
    
    func onPressCloseScanner() {
        visibalQrScanner = false
    }
}

struct QrCodeScannerViewExample: View {
    @StateObject var model = QrCodeScannerViewModelExample()
    
    var body: some View {
        if model.visibalQrScanner {
            ZStack {
                VStack {
                    QrCodeScannerView()
                        .found(onResult: model.onFoundQrCode)
                        .frame(
                            width: UIScreen.main.bounds.width - 16,
                            height: UIScreen.main.bounds.width - 16
                        )
                    
                    Button {
                        model.onPressCloseScanner()
                    } label: {
                        Text("* Close scanner *")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(8)
                }
            }
        } else {
            VStack {
                if model.value.count > 0 {
                    Group {
                        Text("Scanned QR value:")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Text(model.value)
                            .foregroundColor(Color.green)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
                
                Button {
                    model.onPressShowScanner()
                } label: {
                    Text("* Open QR scanner *")
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
}
