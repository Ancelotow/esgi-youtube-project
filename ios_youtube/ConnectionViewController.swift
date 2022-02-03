//
//  ConnectionViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 29/01/2022.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher

class ConnectionViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    private let service = GTLRYouTubeService()
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = Session.SCOPES
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    @IBAction func connection(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.service.authorizer = nil
        } else {
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            Session.openSession(authentication: user.authentication)
        }
    }
    
}
