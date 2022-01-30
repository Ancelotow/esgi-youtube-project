//
//  ConnectionViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 29/01/2022.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class ConnectionViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var btnConnection: GIDSignInButton!
    private let service = GTLRYouTubeService()
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()

        // Add the sign-in button.
        view.addSubview(btnConnection)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                 withError error: Error!) {
           if let error = error {
           } else {
               self.btnConnection.isHidden = true
           }
       }

}
