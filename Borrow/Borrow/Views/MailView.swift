//
//  MailView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
  
  @Binding var isShowing: Bool
  @Binding var result: Result<MFMailComposeResult, Error>?
  
  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    init(isShowing: Binding<Bool>,
         result: Binding<Result<MFMailComposeResult, Error>?>) {
      _isShowing = isShowing
      _result = result
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
      defer {
        isShowing = false
      }
      guard error == nil else {
        self.result = .failure(error!)
        return
      }
      self.result = .success(result)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShowing: $isShowing,
                       result: $result)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let vc = MFMailComposeViewController()
    vc.mailComposeDelegate = context.coordinator
    return vc
  }
  
  func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                              context: UIViewControllerRepresentableContext<MailView>) {
    
  }
}

struct MailView_Previews: PreviewProvider {
  static var previews: some View {
    MailView(isShowing: .constant(false), result: .constant(.success(MFMailComposeResult(rawValue: 0)!)))
  }
}
