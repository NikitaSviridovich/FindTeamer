//
//  MainComponents.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI

struct EventCell: View  {
    // MARK: - Internal properties
    @State var event: EventModel
    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: EventDetailsView(event: event)) {
            Image((event.eventType ?? "").lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading, spacing: 4) {
                Text(event.eventType ?? "")
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(.gray)
                Text(event.eventAddress ?? "")
                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                    .foregroundColor(.gray)
                Text((event.eventTime ?? Date()).formatted())
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(Color.gray)
            }
        }
    }
}
