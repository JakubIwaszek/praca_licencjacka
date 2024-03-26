//
//  Item.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 03/11/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
