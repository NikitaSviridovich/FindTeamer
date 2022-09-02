//
//  MainComponents.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI


struct eventCellGenerator : View  {
    @State var event: EventModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.eventTitle)
            .font(.headline)
            Text(event.eventType)
            .font(.subheadline)
            Text(event.eventTime.formatted(.dateTime))
            .font(.subheadline)
        }
    }
}

struct plusButton : View {
    @State var action : Bool = false
    var body: some View {
        Button(action: {
            self.action.toggle()
        }, label: {
        Text("+")
            .font(.system(.largeTitle))
            .frame(width: 77, height: 70)
            .foregroundColor(Color.white)
            .padding(.bottom, 7)
        })
        .background(Color.green)
        .cornerRadius(38.5)
        .padding()
        .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
    }
}
