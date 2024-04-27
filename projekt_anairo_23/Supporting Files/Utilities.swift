//
//  Utilities.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 24/11/2023.
//

import SwiftUI
import PhotosUI

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

extension PhotosPickerItem {
    func loadTransferable(completion: @escaping (Data?) -> Void) -> Progress {
        return self.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData?):
                    // Handle the success case with the image.
                    completion(imageData)
                case .success(nil):
                    // Handle the success case with an empty value.
                    completion(nil)
                case .failure(let error):
                    // Handle the failure case with the provided error.
                    completion(nil)
                }
            }
        }
    }
}
