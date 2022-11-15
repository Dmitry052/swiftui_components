//
//  SpecificCornerShape.swift
//  SwiftUI_Components
//
//  Created by Dmitrii on 15.11.2022.
//

import SwiftUI

struct SpecificCornerShapeViewExample: View {
    var body: some View {
        VStack {
            VStack {
                Text("10 : 10")
                Text("3 : 3")
            }
            .frame(width: 200, height: 200)
            .background(Color.green)
            .clipCorners(topLeft: 10, bottomLeft: 3, topRight: 10, bottomRight: 3)
            
            VStack {
                Text("8 : 24")
                Text("16 : 32")
            }
            .frame(width: 200, height: 200)
            .background(Color.red)
            .clipCorners(topLeft: 32, bottomLeft: 16, topRight: 64, bottomRight: 32)
        }
    }
}

struct SpecificCornerShape_Previews: PreviewProvider {
    static var previews: some View {
        SpecificCornerShapeViewExample()
    }
}
