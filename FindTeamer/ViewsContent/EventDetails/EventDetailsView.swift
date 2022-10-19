//
//  EventDetailsView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI

struct EventDetailsView: View {
    // MARK: - Private properties

    private var event: EventModel
    private var viewModel: EventDetailsViewModel
    private let urlForMap: String = "http://maps.apple.com/?address="
    private let commonTextSize = 15.0
    private let linkTextSize = 12.0

    // MARK: - Initializators

    init(event: EventModel = EventModel(), viewModel: EventDetailsViewModel = EventDetailsViewModel()) {
        self.event = event
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Image((event.eventType ?? "").lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.eventType ?? "" + " | " + (event.eventTitle ?? ""))
                        .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
            .background(Color.white.cornerRadius(5).shadow(radius: 3))
            VStack(alignment: .leading) {
                HStack {
                    Text(event.eventAddress ?? "").padding()
                        .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openURLLink(url: urlForMap + (event.eventAddress ?? ""))
                    }) { Text("See on Map").font(.system(size: linkTextSize, weight: .light, design: .default)) }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventPhoneNumber ?? "").padding()
                        .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openURLLink(url: "tel:" + (event.eventPhoneNumber ?? ""))
                    }) {
                        Text("Make a Call").font(.system(size: linkTextSize, weight: .light, design: .default))
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventEmail ?? "").padding()
                        .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Copy the Email").font(.system(size: linkTextSize, weight: .light, design: .default)).onTapGesture(count: 1) {
                        viewModel.copyEmail(email: event.eventEmail ?? "")
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text((event.eventTime ?? Date()).formatted()).padding()
                        .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                }
                Divider().background(Color.white).padding(.trailing, 128)
                Text((event.eventDescription ?? "")).padding()
                    .font(.system(size: commonTextSize, weight: .black, design: .rounded))
                    .foregroundColor(.gray)
                Divider().background(Color.white).padding(.trailing, 128)
            }
            Spacer()
        }.padding()
    }
    func openURLLink(url: String) {
        viewModel.openURLLink(url: url)
    }
}
