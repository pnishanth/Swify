
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

//Touch ID and FaceID

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authenticationWithTouchID()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}


