//
//  Session.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher

// Singleton
public class Session {
    
    private static var session: Session? = nil
    let API_KEY = "AIzaSyBMMt_y8ZWqbJiqYoosDqpEdsK26i9R584"
    private var accessToken: String // Token a utilisé dans les appels API
    private var idToken: String
    
    // Listes des différents droits nécessaire pour l'application
    public static let SCOPES =  [
                                    kGTLRAuthScopeYouTubeReadonly,
                                    kGTLRAuthScopeYouTube,
                                    kGTLRAuthScopeYouTubeForceSsl,
                                    kGTLRAuthScopeYouTubeChannelMembershipsCreator,
                                    kGTLRAuthScopeYouTubeYoutubepartnerChannelAudit,
                                    kGTLRAuthScopeYouTubeReadonly,
                                    kGTLRAuthScopeYouTubeUpload
                                ]
    
    private init(accessToken: String, idToken: String) {
        self.accessToken = accessToken
        self.idToken = idToken
    }
    
    static func openSession(authentication: GIDAuthentication) -> Session {
        if session == nil {
            print(authentication.accessToken)
            session = Session(accessToken: authentication.accessToken, idToken: authentication.idToken)
        }
        return session!
    }
    
    static func getSession() -> Session? {
        return session
    }
    
    func getAccessToken() -> String {
        return self.accessToken
    }
    
}
