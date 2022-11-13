//
//  QrCodeScannerView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

struct QrCodeScannerView: UIViewRepresentable {
  private let supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
  private let session = AVCaptureSession()
  private let delegate = QrCodeCameraDelegate()
  private let metadataOutput = AVCaptureMetadataOutput()
  
  func found(onResult: @escaping (String) -> Void) -> QrCodeScannerView {
    delegate.onResult = onResult
    return self
  }
  
  func makeUIView(context: UIViewRepresentableContext<QrCodeScannerView>) -> QrCodeScannerView.UIViewType {
    let cameraView = QRCodeCameraPreview(session: session)
    checkCameraAuthorizationStatus(cameraView)
    return cameraView
  }
  
  func updateUIView(_ uiView: QRCodeCameraPreview, context: UIViewRepresentableContext<QrCodeScannerView>) {
    uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
  }
  
  private func checkCameraAuthorizationStatus(_ uiView: QRCodeCameraPreview) {
    let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    
    if cameraAuthorizationStatus == .authorized {
      setupCamera(uiView)
    } else {
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.sync {
          if granted {
            self.setupCamera(uiView)
          }
        }
      }
    }
  }
  
  private func setupCamera(_ uiView: QRCodeCameraPreview) {
    if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
      if let input = try? AVCaptureDeviceInput(device: backCamera) {
        let dispatchQueue = DispatchQueue(label: "QRScanner", qos: .background)
        session.sessionPreset = .photo
        
        if session.canAddInput(input) {
          session.addInput(input)
        }
        if session.canAddOutput(metadataOutput) {
          session.addOutput(metadataOutput)
          
          metadataOutput.metadataObjectTypes = supportedBarcodeTypes
          metadataOutput.setMetadataObjectsDelegate(delegate, queue: dispatchQueue)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer.videoGravity = .resizeAspectFill
        uiView.layer.addSublayer(previewLayer)
        uiView.previewLayer = previewLayer
        
        dispatchQueue.async {
          self.session.startRunning()
        }
      }
    }
  }
  
  static func dismantleUIView(_ uiView: QRCodeCameraPreview, coordinator: ()) {
    uiView.session.stopRunning()
  }
}

struct QrCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeScannerViewExample()
    }
}
