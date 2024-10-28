//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/25/24.
//

import Foundation
import Fluent

struct CreateUserTableMigration: AsyncMigration {

    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("users").delete()
    }
    
    
}


