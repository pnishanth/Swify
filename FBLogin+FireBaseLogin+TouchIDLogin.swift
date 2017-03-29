
import UIKit
import LocalAuthentication
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

//Additions to App delegate didFinishLaunchingWithOptions
//FIRApp.configure()
//FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//-----------------------------------------------------------------------------------------------------------
// application url
// return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)

//MARK : FacebookLogin
func facebookLogin(){

let FbLoginManager : FBSDKLoginManager = FBSDKLoginManager()

FbLoginManager.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
    if error == nil{
        let credential = FIRFacebookAuthProvider.credential(withAccessToken:FBSDKAccessToken.current().tokenString)
        print("Logged in Through Facebook")
        self.fireBaseAuth(credential)
        
    }
    else{
        print("FBLoginError")
    }
    
}

}


//MARK : FireBaseLogin
func fireBaseAuth(_ credential : FIRAuthCredential ){
    
    FIRAuth.auth()?.signIn(with:credential,completion : { (user, error) in
        
        if error != nil{
            print("Unable to login with Firebase -\(error)")
            
        }else
        {
            self.display_Name = (user?.displayName)!
            self.email = (user?.email)!
            let displaypic_url = (user?.photoURL)!
            print(displaypic_url)
            
            
            let data = try? Data(contentsOf: displaypic_url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.display_pic = UIImage(data: data!)
            
            /* DispatchQueue.global().async {
             let data = try? Data(contentsOf: displaypic_url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
             DispatchQueue.main.async {
             self.display_pic = UIImage(data: data!)!
             }
             }
             */
            
            print("Succesfull login with \n Display_Name:\(self.display_Name) \n Email_id:\(self.email)")
            
            
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
            
        }
        
        
        
        
    })
    
    
}


var Auth : Bool = false

//MARK : Email login
@IBAction func Login(_ sender: Any) {
    
    if let email = userName.text, let pwd = password.text{
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: {
            (user,error) in
            if error == nil{
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
                print("Signed in using firebase")
            }
            else{
                FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user,error) in
                    if error != nil{
                        print("Unable to sign in")
                    }else{
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                        print("Successfully authenticated with FireBase")
                    }
                })
                print(error)
            }
        })
    }
    self.performSegue(withIdentifier: "LoginSegue", sender: self)
}



