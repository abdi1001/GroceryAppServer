//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/28/24.
//

import Foundation
import Vapor

struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {
    func authenticate(request: Vapor.Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }

}
