//
//  ZigZagShape.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 11/2/23.
//

import SwiftUI

struct ZigZagShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        
        let zigZagWidth: CGFloat = 7
        let zigZagHeight: CGFloat = 5
        var yInitial = height - zigZagHeight
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: yInitial))
        
        var slope = -1
        var x: CGFloat = 0
        var i = 0
        while x < width {
            x = zigZagWidth * CGFloat(i)
            let p = zigZagHeight * CGFloat(slope)
            let y = yInitial + p
            path.addLine(to: CGPoint(x: x, y: y))
            slope = slope * (-1)
            i += 1
        }
        
        path.addLine(to: CGPoint(x: width, y: 0))
        
        yInitial = 0 + zigZagHeight
        x = CGFloat(width)
        i = 0
        while x > 0 {
            x = width - (zigZagWidth * CGFloat(i))
            let p = zigZagHeight * CGFloat(slope)
            let y = yInitial + p
            path.addLine(to: CGPoint(x: x, y: y))
            slope = slope * (-1)
            i += 1
        }

        return path
    }
}
#Preview {
    ZigZagShape()
}
