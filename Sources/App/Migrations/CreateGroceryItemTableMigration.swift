//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/27/24.
//

import Foundation
import Fluent

class CreateGroceryItemTableMigration: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .field("price", .double, .required)
            .field("quantity", .int, .required)
            .field("grocery_category_id", .uuid, .required, .references("grocery_categories", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("grocery_items").delete()
    }
}
