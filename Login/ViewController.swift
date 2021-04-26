//
//  ViewController.swift
//  Login
//
//  Created by MD Tanvir Alam on 26/4/21.
//




import FBSDKLoginKit

// Add this to the body
class ViewController: UIViewController, LoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current,!token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { connection, result, error in
                print(result)
            }
        }else{
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
            loginButton.delegate = self
        }
    }
    
    //MARK:- FBLoginDelegate
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { connection, result, error in
            print(result)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}



