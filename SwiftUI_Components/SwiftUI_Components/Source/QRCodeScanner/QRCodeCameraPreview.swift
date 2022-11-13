//
//  QRCodeCameraPreview.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import UIKit
import Foundation
import AVFoundation

class QRCodeCameraPreview: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    
    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}
