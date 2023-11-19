import SwiftUI

struct ZigZagShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height * 2
        
        let originalZigZagWidth: CGFloat = 6
        let originalZigZagHeight: CGFloat = 4
        
        // Adjust the zigZagWidth to increase the frequency by 3/2
        let zigZagWidth: CGFloat = originalZigZagWidth * 3 / 2
        let zigZagHeight: CGFloat = originalZigZagHeight
        
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

        // Apply gradient to the top edge of the path
        let gradient = LinearGradient(gradient: Gradient(colors: [Color(red: 0.8, green: 0, blue: 0), Color(red: 0, green: 0, blue: 0.8)]), startPoint: .top, endPoint: .bottom)
        path = path.applying(.init(scaleX: 1, y: -1)).applying(.init(translationX: 0, y: rect.size.height))
        path.fill(gradient)
        
        return path
    }
}

struct ZigZagShape_Previews: PreviewProvider {
    static var previews: some View {
        ZigZagShape()
    }
}
