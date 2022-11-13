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
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
