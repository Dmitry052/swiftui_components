//
//  WrapHStackView.swift
//  SwiftUI_Components
//
//  Created by Dmitrii Aleksandrovich on 13.11.2022.
//
import SwiftUI

struct WrapHStackView<Content: View>: View {
    var parentWidth: Double
    var content: [Content]
    var hAlignment: Alignment = .leading
    var vAlignment: Alignment = .leading
    
    private struct ComponentMmeasurement: Equatable {
        var indexOfContent: Int
        var size: CGSize
    }
    
    @State private var preparationContent = true
    @State private var measurements: [ComponentMmeasurement] = []
    @State private var rows: [[Content]] = [[]]
    
    var body: some View {
        VStack(spacing: 0) {
            if preparationContent {
                VStack(spacing: 0) {
                    ForEach(0..<content.count, id: \.self) { index in
                        content[index].background(GeometryReader { geo in
                            Color.clear.onAppear {
                                measurements.append(
                                    ComponentMmeasurement(indexOfContent: index, size: geo.size)
                                )
                            }
                        })
                    }
                }
                .opacity(0)
                .onChange(of: measurements) { value in
                    if value.count == content.count {
                        measurements = measurements.sorted(by: { component1, component2 in
                            component1.indexOfContent < component2.indexOfContent
                        })
                        generateRows()
                    }
                }
            } else {
                VStack(spacing: 0) {
                    ForEach(0..<rows.count, id: \.self) { index in
                        HStack(spacing: 0) {
                            ForEach(0..<rows[index].count, id: \.self) { indexofRow in
                                rows[index][indexofRow]
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: hAlignment)
                    }
                }
                .frame(maxWidth: .infinity, alignment: vAlignment)
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: content.count) { _ in
            updateRows()
        }
    }
    
    func updateRows() {
        rows = [[]]
        measurements = []
        preparationContent = true
    }
    
    func generateRows() {
        var rowIndex = 0
        var countSize = 0.0
        var maxRowHeight = 0.0
        
        for measurement in measurements {
            if measurement.size.width + countSize < parentWidth {
                countSize += measurement.size.width
                rows[rowIndex].append(content[measurement.indexOfContent])
            } else {
                countSize = measurement.size.width
                rowIndex += 1
                
                rows.append([])
                rows[rowIndex].append(content[measurement.indexOfContent])
            }
            
            if measurement.size.height > maxRowHeight {
                maxRowHeight = measurement.size.height
            }
        }
        
        preparationContent = false
    }
}


struct WrapHStackView_Previews: PreviewProvider {
    static var previews: some View {
        WrapHStackExample()
    }
}
