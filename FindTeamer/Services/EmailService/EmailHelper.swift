//
//  EmailHelper.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 9.09.22.
//

import SwiftUI
import MessageUI

struct EmailHelper {
    var content: String
    var to: String
    var subject: String
}

extension EmailHelper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail(){
            let view = MFMailComposeViewController()
            view.mailComposeDelegate = context.coordinator
            view.setToRecipients([to])
            view.setSubject(subject)
            view.setMessageBody(content, isHTML: false)
            return view
        } else {
            return MFMailComposeViewController()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator : NSObject, MFMailComposeViewControllerDelegate {
        var parent : EmailHelper
        init(_ parent: EmailHelper){
            self.parent = parent
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}

