//
//  ChartView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct ChartView: View {
    @State private var selectedDate = Date()
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

        }
    }


    func getCurrentMonth() -> String {
           let currentDate = Date()
           let calendar = Calendar.current
           let month = calendar.component(.month, from: currentDate)
           return String(month)
       }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}


