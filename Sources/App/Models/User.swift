//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/25/24.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Validatable, Content, @unchecked Sendable {

    
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() {}
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("username", as: String.self, is: !.empty, customFailureDescription: "Username cannot be empty.")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "Password cannot be empty.")
        
        //
        validations.add("password", as: String.self, is: .count(6...16), customFailureDescription: "password must be between 6 and 16 characters.")
    }
    
    
}
