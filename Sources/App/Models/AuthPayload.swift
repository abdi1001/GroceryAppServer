//
//  File.swift
//  grocery-app-server
//
//  Created by abdifatah ahmed on 10/25/24.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {

    typealias Payload = AuthPayload

    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case userID = "uid"
    }
    
    var expiration: ExpirationClaim
    var userID: UUID
    
    func verify(using signer: JWTKit.JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
