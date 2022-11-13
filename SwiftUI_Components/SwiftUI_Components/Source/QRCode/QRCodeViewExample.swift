//
//  ExampleQRCodeView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import SwiftUI

struct QRCodeViewExample: View {
    let maxWidth = UIScreen.main.bounds.width - 32
    @State var text = "Hellow World"
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack {
                    TextField("Enter value for QR", text: .constant(""))
                        .disabled(true)
                        .multilineTextAlignment(.center)
                    
                    TextEditor(text: $text)
                        .frame(maxWidth: maxWidth, minHeight: 100)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                        .frame(maxWidth: maxWidth, maxHeight: 1)
                        .background(Color.black.opacity(0.3))
                }
                .frame(maxWidth: maxWidth, maxHeight: .infinity)
                
                QRCodeView(
                    width: maxWidth,
                    height: maxWidth,
                    value: text
                )
            }
        }
    }
}

struct ExampleQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeViewExample()
    }
}
