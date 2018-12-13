//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Yoshiaki Kato on 2018/11/04.
//  Copyright © 2018 Yoshiaki Kato. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    //Googleサインインに関するデリゲートメソッド
    //signIn:didSignInForUser:withError: メソッドで、Google ID トークンと Google アクセス トークンを
    //GIDAuthentication オブジェクトから取得して、Firebase 認証情報と交換します。
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //引数を変数に代入、引数が存在するか？
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        //認証情報
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        
        //最後に、認証情報を使用して Firebase での認証を行います
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("\nLogin successful\n")
            self.transitionToChatRoom()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    //チャット画面への遷移メソッド
    func transitionToChatRoom() {
        //"toChatRoom"というIDで識別
        performSegue(withIdentifier: "toChatRoom", sender: self)
    }
    
    //サインアウト押下
    @IBAction func tappedSignOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("SignOut is successed")
            reloadInputViews()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
