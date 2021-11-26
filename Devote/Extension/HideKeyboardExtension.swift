//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Yok on 25/11/2564 BE.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
