//
//  Utilities.swift
//  projekt_anairo_23
//
//  Created by Przemysław Szwajcowski on 24/11/2023.
//

import SwiftUI

extension Color {
    public static var lightGray: Color = {
        return Color(.lightGray)
    }()
    
    public static var mainBackgroundColor: Color = {
        return Color("mainBackgroundColor")
    }()
    
    public static var postBackgroundColor: Color = {
        return Color("postBackgroundColor")
    }()
    
    public static var loginBackgroundColor: Color = {
        return Color("loginBackgroundColor")
    }()
}

extension DateFormatter {
    public static var firestoreDateFormatter: DateFormatter = {
        // 2024-01-20 16:57:20 +0000
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        return dateFormatter
    }()
}
