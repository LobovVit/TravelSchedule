//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Vitaly Lobov on 07.04.2025.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var filter: Filter
    @State var currentFilter = Filter()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
                .padding(16.0)
            
            TimeOptionView(
                title: "Утро 06:00 - 12:00",
                isSelected: $currentFilter.isMorning
            )
            
            TimeOptionView(
                title: "День 12:00 - 18:00",
                isSelected: $currentFilter.isAfternoon
            )
            TimeOptionView(
                title: "Вечер 18:00 - 00:00",
                isSelected: $currentFilter.isEvening
            )
            TimeOptionView(
                title: "Ночь 00:00 - 06:00",
                isSelected: $currentFilter.isAtNight
            )
            
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))
                .padding(16.0)
            
            VStack(spacing: 0) {
                TransferOptionView(
                    title: "Да",
                    isSelected: $currentFilter.isWithTransfers
                )
                
                TransferOptionView(
                    title: "Нет",
                    isSelected: $currentFilter.isWithTransfers.not
                )
            }
            
            Spacer()
            
            if currentFilter != filter {
                Button {
                    filter = currentFilter
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(.ypBlue)
                .foregroundStyle(.ypWhite)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16.0)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            currentFilter = filter
        }
    }
}

struct TimeOptionView: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title).padding(16.0)
            Spacer()
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(16.0)
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct TransferOptionView: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            HStack {
                Text(title)
                    .padding(16.0)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(16.0)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FilterView(filter: .constant(Filter.fullSearch))
}
