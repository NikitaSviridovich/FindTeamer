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
                    Text(event.eventType)
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)            .background(Color.white.cornerRadius(5).shadow(radius: 3))
            VStack(alignment: .leading) {
                Text(event.eventTitle).padding()
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundColor(.gray)
                Divider().background(Color.white).padding(.trailing, 128)
                Text(event.eventAddress).padding()
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundColor(.gray)
                Divider().background(Color.white).padding(.trailing, 128)
                Text(event.eventDescription).padding()
                .font(.system(size: 16, weight: .black, design: .rounded))
                .foregroundColor(.gray)
                Divider().background(Color.white).padding(.trailing, 128)
            }
            Spacer()
            if MFMailComposeViewController.canSendMail() {
                Button(action: sendEmailAction) {
                    ButtonContent(text: "Send Info on Email")
                }.sheet(isPresented: $sendEmail) {
                    EmailHelper(content: event.eventDescription, to: "",subject: event.eventTitle)
                }
            }
        }.padding()
    }
    
    private func sendEmailAction() {
        sendEmail.toggle()
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
