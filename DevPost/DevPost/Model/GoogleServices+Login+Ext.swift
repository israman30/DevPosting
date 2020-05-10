//
//  GoogleServices+Login+Ext.swift
//  DevPost
//
//  Created by Israel Manzo on 5/10/20.
//  Copyright © 2020 Israel Manzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import ProgressHUD

// MARK: - ************* GOOGLE SIGNIN EXTENSION *************
extension LoginController: GIDSignInDelegate {
    
    // MARK: - Google Signup block
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // Create access toke for user
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error {
                print("Error signin up a user", error.localizedDescription)
            }
            // Signin a user
            guard let uid = user?.user.uid else { return }
            print("User has logged in using Google", uid)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User has disconetec")
        ProgressHUD.show("User has disconnected")
    }
    
    func googlePReseterDelegatesWithUserPResistance() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
}
