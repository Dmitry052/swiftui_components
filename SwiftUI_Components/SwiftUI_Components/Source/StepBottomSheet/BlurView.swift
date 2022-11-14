//
//  BlurView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 14.11.2022.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
  var style: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
    return view
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
  }
}
