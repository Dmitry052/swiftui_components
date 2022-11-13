//
//  QRCodeView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let width: CGFloat
    let height: CGFloat
    let value: String
    
    var body: some View {
      Image(uiImage: generateQRCode(from: value))
        .resizable()
        .interpolation(.none)
        .scaledToFit()
        .frame(width: width, height: height)
    }
    
    func generateQRCode(from string: String) -> UIImage {
      filter.message = Data(string.utf8)
      
      if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
          return UIImage(cgImage: cgimg)
        }
      }
      
      return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeViewExample()
    }
}
