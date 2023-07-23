//
//  ChartView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct ChartView: View {
    @State private var selectedDate = Date()
    @State private var wholeCost = 123102
    @State private var eatenCost = 43200
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "M" // Format to display month and year
            return formatter
        }()

    var body: some View {
        VStack(alignment: .center){
            Spacer()
                .frame(height: 32.adjusted)

            HStack(alignment: .top){
                Text("통계")
                    .font(.system(size: 28.adjusted).weight(.bold))
                    .foregroundColor( Color("PrimaryGB"))

                Spacer()

            }
            .padding(.horizontal, 20.adjusted)

            Spacer()
                .frame(height: 26.adjusted)

            HStack(alignment: .center) {
                Button(action: {
                    // Go to the previous month
                    selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("Gray900"))
                        .padding()
                }

                Text("\(dateFormatter.string(from: selectedDate))월")
                    .font(.system(size: 22.adjusted))
                    .foregroundColor(Color("Gray900"))

                Button(action: {
                    // Go to the next month
                    if( dateFormatter.string(from: selectedDate) != getCurrentMonth()){
                        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(dateFormatter.string(from: selectedDate) == getCurrentMonth() ? Color("Gray200") : Color("Gray900") )
                        .padding()
                }
            }

            Spacer()
                .frame(height: 41.adjusted)

            Pie(slices: [
                (7, Color("PrimaryGB")),
                (3, Color("Gray200"))
                ])
            .frame(width: 250.adjusted)

            summaryList
                .padding(.horizontal, 20.adjusted)
                .padding(.vertical, 38.adjusted)

            Spacer()
        }
    }

    private var summaryList: some View{
        VStack(spacing: 15.adjusted){
            HStack{
                Text("전체")
                Spacer()
                Text("\(wholeCost)원")
            }
            HStack{
                Text("잘 먹은 금액")
                Spacer()
                Text("\(eatenCost)원")
            }
            HStack{
                Text("낭비된 금액")
                Spacer()
                Text("\(wholeCost - eatenCost)원")
            }
        }
    }


    func getCurrentMonth() -> String {
           let currentDate = Date()
           let calendar = Calendar.current
           let month = calendar.component(.month, from: currentDate)
           return String(month)
       }
}

struct Pie: View {

    @State var slices: [(Double, Color)]

    var body: some View {
        Canvas { context, size in
            let donut = Path { p in
                p.addEllipse(in: CGRect(origin: .zero, size: size))
                p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
            }
            context.clip(to: donut, style: .init(eoFill: true))

            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle


                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))

                startAngle = endAngle
            }

        }
        .aspectRatio(1, contentMode: .fit)
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}


