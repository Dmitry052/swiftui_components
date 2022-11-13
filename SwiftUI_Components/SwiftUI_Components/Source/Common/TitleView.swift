//
//  TitleView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//

import SwiftUI

struct TitleView: View {
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(Array(0..<title.count + 7).map({ _ in
                "*"
            }).joined())
            .font(.system(size: 20))
            .fontWeight(.bold)
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
            Text(Array(0..<title.count + 7).map({ _ in
                "*"
            }).joined())
            .font(.system(size: 20))
            .fontWeight(.bold)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "TitleView")
    }
}
