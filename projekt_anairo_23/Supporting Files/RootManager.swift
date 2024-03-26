//
//  RootManager.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import Foundation

final class RootManager: ObservableObject {
    @Published var currentRoot: Roots = .authentication
    
    enum Roots {
        case home
        case authentication
    }
}
