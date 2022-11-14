//
//  StepBottomSheetViewExample.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 14.11.2022.
//

import SwiftUI

struct StepBottomSheetViewExample: View {
    var body: some View {
        StepBottomSheetView(
            bottomSheetContent: { onPressClose, lastOffset in
                ZStack {
                    Color.green
                    
                    Button {
                        onPressClose()
                    } label: {
                        Text("Close bottom sheet")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(8)
                }
                .frame(maxHeight: UIScreen.main.bounds.height - lastOffset)
            }, content: { onPressShow in
                ZStack {
                    Color.clear
                    
                    Button {
                        withAnimation {
                            onPressShow()
                        }
                    } label: {
                        Text("Open bottom sheet")
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(8)
                }
            })
        .ignoresSafeArea(.all)
    }
}

struct StepBottomSheetViewExample_Previews: PreviewProvider {
    static var previews: some View {
        StepBottomSheetViewExample()
    }
}
