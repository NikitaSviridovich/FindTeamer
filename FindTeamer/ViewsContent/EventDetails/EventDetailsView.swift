//
//  EventDetailsView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI

struct EventDetailsView: View {
    var event: EventModel
    
    var body: some View {
        VStack {
            HStack {
                Image(event.eventType.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.eventType)
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(.gray)
                    Text(event.eventDescription)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(Color.gray)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)            .background(Color.white.cornerRadius(5).shadow(radius: 3))
            Spacer()
        }.padding()
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let event = EventModel()
        return NavigationView {
            EventDetailsView(event: event)
        }
    }
}
