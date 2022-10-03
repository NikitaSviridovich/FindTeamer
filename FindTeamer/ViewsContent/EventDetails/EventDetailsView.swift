//
//  EventDetailsView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI
import MessageUI

struct EventDetailsView: View {
    // MARK: - Public properties
    var event: EventModel
    @State private var sendEmail = false
    
    // MARK: - Private properties
    private let urlForMap: String = "http://maps.apple.com/?address="
    
    // MARK: - Initializators
    init(event: EventModel = EventModel()) {
        self.event = event
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Image(event.eventType.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.eventType + " | " + event.eventTitle)
                        .font(.system(size: 14, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
            .background(Color.white.cornerRadius(5).shadow(radius: 3))
            VStack(alignment: .leading) {
                HStack {
                    Text(event.eventAddress).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openURLLink(url: urlForMap + event.eventAddress)
                    }) { Text("See on Map").font(.system(size: 12, weight: .light, design: .default)) }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventPhoneNumber).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openURLLink(url: "tel:" + event.eventPhoneNumber)
                    }) {
                        Text("Make a Call").font(.system(size: 12, weight: .light, design: .default))
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventEmail).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Copy the Email").font(.system(size: 12, weight: .light, design: .default)).onTapGesture(count: 1) {
                        UIPasteboard.general.string = event.eventEmail
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventTime.formatted()).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openURLLink(url: "tel:" + event.eventPhoneNumber)
                    }) {
                        Text("Add Notification").font(.system(size: 12, weight: .light, design: .default))
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                Text(event.eventDescription).padding()
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundColor(.gray)
                Divider().background(Color.white).padding(.trailing, 128)
            }
        }.padding()
    }
    
    // MARK: - Methods
    private func openURLLink(url: String) {
        UIApplication.shared.open(NSURL(string: url)! as URL)
    }
}
