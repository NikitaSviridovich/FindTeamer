//
//  EventDetailsView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 2.09.22.
//

import SwiftUI
import MessageUI

struct EventDetailsView: View {
    @State private var sendEmail = false
    var event: EventModel
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
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)            .background(Color.white.cornerRadius(5).shadow(radius: 3))
            VStack(alignment: .leading) {
                HStack {
                    Text(event.eventAddress).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        openMap(address: event.eventAddress)
                    }) {
                        Text("See on Map").font(.system(size: 12, weight: .light, design: .default))
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventPhoneNumber).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        makeACall(url: "tel:" + event.eventPhoneNumber)
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
                    Button(action: {
                        makeACall(url: "tel:" + event.eventPhoneNumber)
                    }) {
                        Text("Sent an Email").font(.system(size: 12, weight: .light, design: .default))
                    }
                }
                Divider().background(Color.white).padding(.trailing, 128)
                HStack {
                    Text(event.eventTime.formatted()).padding()
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        makeACall(url: "tel:" + event.eventPhoneNumber)
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
//            Spacer()
//            if MFMailComposeViewController.canSendMail() {
//                Button(action: sendEmailAction) {
//                    ButtonContent(text: "Send Info on Email")
//                }.sheet(isPresented: $sendEmail) {
//                    EmailHelper(content: event.eventDescription, to: "",subject: event.eventTitle)
//                }
//            }
        }.padding()
    }
    private func sendEmailAction() {
        sendEmail.toggle()
    }
    private func openMap(address: String) {
        UIApplication.shared.open(NSURL(string: "http://maps.apple.com/?address=\(address)")! as URL)
    }
    private func makeACall(url: String) {
        UIApplication.shared.open(NSURL(string: url)! as URL)
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
