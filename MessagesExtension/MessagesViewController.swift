//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Tuncay Cansız on 16.10.2019.
//  Copyright © 2019 Tuncay Cansız. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
  
  override func viewDidLoad() {
  
  }
  
  // MARK: - Child view controller presentation
  private func presentViewController(for conversation: MSConversation, with: MSMessagesAppPresentationStyle) {
    var controller : UIViewController!
    
    if presentationStyle == .compact {
      controller = instantiateARObjectViewController()
    }
    else{
      controller = instantiateARObjectViewController()
    }
      
    addChild(controller)
      
    controller.view.frame = view.bounds
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(controller.view)
      
    NSLayoutConstraint.activate([controller.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                                 controller.view.rightAnchor.constraint(equalTo: view.rightAnchor),
                                 controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                                 controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    controller.didMove(toParent: self)
  }
  
  // MARK: - Properties
  private func instantiateARObjectViewController() -> UIViewController {
    guard let controller = self.storyboard?.instantiateViewController(identifier: "ARObject") as? ARObjectViewController
      else {
        fatalError("ARObjectViewController not found")
    }
    controller.delegate = self
    return controller
  }
  
  override func willBecomeActive(with conversation: MSConversation) {
    presentViewController(for: conversation, with: presentationStyle)
  }
}

/// Extends `MessagesViewController` to conform to the `ARObjectViewControllerDelegate` protocol.
extension MessagesViewController: ARObjectViewControllerDelegate {

  func sendARObject(fileName: String, objectImageName: String) {
    print("fileName: ", fileName)
    print("objectImageName: ", objectImageName)
    
    guard let usdzFileURL = Bundle.main.url(forResource: "\(fileName)", withExtension: "usdz") else {
      return
    }
    
    print("usdzfile:", usdzFileURL)
    
    self.activeConversation?.insertAttachment(usdzFileURL, withAlternateFilename: nil, completionHandler: { (error) in
      if let error = error {
        print(error)
      }
    })
  }
}
