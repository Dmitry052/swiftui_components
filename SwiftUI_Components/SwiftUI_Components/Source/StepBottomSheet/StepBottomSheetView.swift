//
//  StepBottomSheetView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 14.11.2022.
//

import SwiftUI

fileprivate let DEFAULT_OFFSET = UIScreen.main.bounds.height / 2

struct StepBottomSheetView<BottomSheetContent: View, Content: View>: View {
    let callbackOnShow: (() -> Void)? = nil
    let callbackOnClose: (() -> Void)? = nil
    let range: [CGFloat]? = []
    let bottomSheetContent: ((_ onPressClose: @escaping () -> Void,
                              _ offset: CGFloat) -> BottomSheetContent)
    let content: ((_ onPressShow: @escaping () -> Void) -> Content)
    
    private let animation: Animation = .linear(duration: 0.2)
    @State private var visible = false
    @State private var offset = 0.0
    @State private var lastOffset = 0.0
    @State private var sortedRange: [CGFloat] = []
    @GestureState private var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
            
            content(onPressShow)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading)
            
            if visible {
                BlurView(style: .systemUltraThinMaterialLight)
                    .transition(.opacity)
                    .onTapGesture {
                        onPressClose()
                    }
                
                bottomSheetContent(onPressClose, lastOffset)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .offset(y: offset)
                    .transition(.move(edge: .bottom))
                    .clipped()
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    }).onEnded { _ in
                        onTapEnded()
                    })
                    .zIndex(2)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomTrailing
        )
        .onAppear {
            sortedRange = range!.sorted()
            
            if sortedRange.count == 0 {
                sortedRange.append(DEFAULT_OFFSET)
            }
        }
    }
    
    private func onTapEnded() {
        withAnimation(animation) {
            let bottomBoundary = sortedRange.last! + (sortedRange.last! * 0.7)
            
            for index in sortedRange.indices {
                if offset > bottomBoundary {
                    onPressClose()
                    break
                } else if sortedRange.count == 1 && offset <= bottomBoundary {
                    offset = sortedRange.first!
                    break
                } else if offset <= sortedRange.first! {
                    offset = sortedRange.first!
                    break
                } else if index + 1 <= sortedRange.count &&
                            sortedRange[index] > offset &&
                            sortedRange[index + 1] < offset {
                    
                    let middleRange = sortedRange[index] + ((sortedRange[index + 1] - sortedRange[index]) / 2)
                    
                    if offset < middleRange {
                        offset = sortedRange[index]
                    } else {
                        offset = sortedRange[index + 1]
                    }
                    break
                }
            }
            
            lastOffset = offset
        }
    }
    
    private func onChange() {
        DispatchQueue.main.async {
            let newOffset = gestureOffset + lastOffset
            
            if newOffset >= sortedRange.first! {
                self.offset = newOffset
            }
        }
    }
    
    private func onPressShow() {
        callbackOnShow?()
        
        withAnimation(animation) {
            if sortedRange.count == 0 {
                offset = DEFAULT_OFFSET
                lastOffset = DEFAULT_OFFSET
            } else {
                offset = sortedRange.first!
                lastOffset = sortedRange.first!
            }
            visible = true
        }
    }
    
    private func onPressClose() {
        callbackOnClose?()
        
        withAnimation(animation) {
            visible = false
        }
    }
}

struct StepBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepBottomSheetViewExample()
    }
}
