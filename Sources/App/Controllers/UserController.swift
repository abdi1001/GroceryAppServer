//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/25/24.
//

import Foundation
import Vapor
import Fluent
import GroceryAppSharedDTO

class UserController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let api = routes.grouped("api")
        
        api.post("register", use: register)
        api.post("login", use: login)
    }
    
    func login(_ req: Request) async throws -> LoginResponseDTO{
        
        let user = try req.content.decode(User.self)
        
        guard let existinUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            return LoginResponseDTO(error: true, reason: "username is not found")
        }
        
        //validate password
        let result = try await req.password.async.verify(user.password,created: existinUser.password)
        
        if !result{
            return LoginResponseDTO(error: true, reason: "Password is not correct")
        }
        
        //generate token and return to user
        let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userID: existinUser.requireID())
        return try LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existinUser.requireID())

    }
    
    func register(_ req: Request) async throws -> RegisterResponseDTO{
        
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first(){
            throw Abort(.conflict, reason: "Username already taken")
        }
        
        user.password = try await req.password.async.hash(user.password)
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
        
    }
    
    
}
