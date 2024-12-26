//
//  Item.swift
//  ssr-webview-ios
//
//  Created by Orhan Aytekin on 26.12.2024.
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
