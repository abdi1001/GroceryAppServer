//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/27/24.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryItemResponseDTO: Content {
    
    init?(_ groceryItem: GroceryItem) {
        
        guard let groceryItemId = groceryItem.id else { return nil }
        
        self.init(id: groceryItemId, title: groceryItem.title, price: groceryItem.price, quantity: groceryItem.quantity)
    }
}
