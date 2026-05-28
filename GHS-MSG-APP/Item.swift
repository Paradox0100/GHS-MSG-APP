//
//  Item.swift
//  GHS-MSG-APP
//
//  Created by Student on 5/28/26.
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
