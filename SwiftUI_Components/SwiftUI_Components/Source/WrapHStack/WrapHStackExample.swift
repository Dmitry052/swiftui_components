//
//  WrapHStackExample.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import SwiftUI

struct WrapHStackExample: View {
    var body: some View {
        VStack {
            TitleView(title: "WrapHStackView")
            ScrollView(.vertical) {
                LazyVStack {
                    WrapHStackView(
                        parentWidth: UIScreen.main.bounds.width - 16,
                        content: Array(0...100).compactMap({ index in
                            VStack {
                                Text("Index: \(index)")
                            }
                            .frame(
                                minWidth: CGFloat.random(in: 80..<200),
                                minHeight: CGFloat.random(in: 20..<100)
                            )
                            .background(Color.green)
                            .cornerRadius(15)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            
                        })
                    )
                }
            }
        }
    }
}

struct WrapHStackExample_Previews: PreviewProvider {
    static var previews: some View {
        WrapHStackExample()
    }
}
