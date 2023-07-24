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

    let itemList: [Receipt] = []
    let data = ["Apple", "Banana", "Orange"]

    var body: some View {

        ScrollView{
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
                    }

                    Text("\(dateFormatter.string(from: selectedDate))월")
                        .font(.system(size: 22.adjusted).weight(.bold))
                        .foregroundColor(Color("Gray900"))
                        .padding(.horizontal, 12.adjusted)

                    Button(action: {
                        // Go to the next month
                        if( dateFormatter.string(from: selectedDate) != getCurrentMonth()){
                            selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(dateFormatter.string(from: selectedDate) == getCurrentMonth() ? Color("Gray200") : Color("Gray900") )
                    }
                }

                Spacer()
                    .frame(height: 41.adjusted)

                Pie(slices: [
                    (7, Color("PrimaryGB")),
                    (3, Color("Gray200"))
                ])
                .frame(width: 200.adjusted)

                summaryList
                    .padding(.horizontal, 20.adjusted)
                    .padding(.vertical, 38.adjusted)

                Group{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: screenWidth, height: 12.adjusted)
                        .background(Color("Gray100"))

                    ListTitle(title: "잘 먹은 BEST3")
                    ListContents(data: data)

                    ListTitle(title: "못 먹은 WORST3")
                    ListContents(data: data)
                }

            }
        }

    }

    private func ListTitle(title: String) -> some View{
        HStack {
            Text(title)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted).weight(.semibold))

            Spacer()
        }
        .padding([.top, .bottom], 17.adjusted)
        .padding([.leading, .trailing], 20.adjusted)

    }

    private func ListContents(data: Array<String>) -> some View{
        ForEach(data, id:\.self) { item in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("")
                        .foregroundColor(.clear)

                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color("Gray200"))
                        .frame(width: 36.adjusted, height: 36.adjusted)

                    Spacer()
                        .frame(width: 12.adjusted)

                    Text(item)
                        .font(.system(size: 17.adjusted).weight(.semibold))
                        .foregroundColor(Color("Gray900"))

                    Spacer()

                    Text("x회")
                        .foregroundColor(Color("Gray900"))
                        .font(.system(size: 14.adjusted).weight(.semibold))
                        .padding(.trailing, 20.adjusted)
                }
                .padding([.top, .bottom], 8.adjusted)
            }

            Divider()
                .overlay(Color("Gray100"))
                .opacity(item == data.last ? 0 : 1)
        }
        .padding([.leading], 20.adjusted)

    }

//    private var worstEaten: some View{
//
//    }

    private var summaryList: some View{
        VStack(spacing: 15.adjusted){
            HStack{
                Text("전체")
                    .font(.system(size: 14).weight(.medium))
                    .foregroundColor(Color("Gray900"))
                Spacer()
                Text("\(wholeCost)원")
                    .font(.system(size: 22).weight(.bold))
                    .foregroundColor(Color("Gray900"))
            }
            HStack{
                Text("잘 먹은 금액")
                    .font(.system(size: 14).weight(.medium))
                    .foregroundColor(Color("Gray900"))
                Spacer()
                Text("\(eatenCost)원")
                    .font(.system(size: 22).weight(.bold))
                    .foregroundColor(Color("Gray900"))
            }
            HStack{
                Text("낭비된 금액")
                    .font(.system(size: 14).weight(.medium))
                    .foregroundColor(Color("Gray900"))
                Spacer()
                Text("\(wholeCost - eatenCost)원")
                    .font(.system(size: 22).weight(.bold))
                    .foregroundColor(Color("PrimaryGB"))
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
                let donutSize = CGSize(width: size.width * 0.3, height: size.height * 0.3) // Reduce the size by 0.8
                            p.addEllipse(in: CGRect(origin: .zero, size: size))
                            p.addEllipse(in: CGRect(x: (size.width - donutSize.width) / 2,
                                                    y: (size.height - donutSize.height) / 2,
                                                    width: donutSize.width, height: donutSize.height))
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


private struct BasicListTitle: View {

    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted).weight(.semibold))

            Spacer()

            Button {

            } label: {
                HStack(spacing: 2.adjusted) {
                    Text("최신순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14.adjusted))
            .padding(.trailing, 20.adjusted)
        }
        .padding([.top, .bottom], 17.adjusted)
        .padding([.leading], 20.adjusted)
    }
}



struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}


