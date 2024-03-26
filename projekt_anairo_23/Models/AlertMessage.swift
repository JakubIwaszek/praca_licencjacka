//
//  AlertMessage.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import Foundation

struct AlertMessage {
    var isPresented = false
    var message: String
    var shouldDismissView = false
    
    mutating func setup(isPresented: Bool, message: String, shouldDismissView: Bool = false) {
        self.isPresented = isPresented
        self.message = message
        self.shouldDismissView = shouldDismissView
    }
}
