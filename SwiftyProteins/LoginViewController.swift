//
//  ViewController.swift
//  SwiftyProteins
//
//  Created by Soto Yanis on 14/04/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginAction(sender: UIButton) {
        // Not every device has a touch ID, so we need a context
        let authenticationContext = LAContext()
        var error:NSError?
        
        
        //Guard cause we don't need to excute the folowed code if return false
        guard authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error)
            else {
                showAlertWithTitle("Error", message: "You this device does not have a TouchID sensor.")
                return
        }
        
        authenticationContext.evaluatePolicy(
            .DeviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Use your fingerprint",
            reply: { (success, error) -> Void in
                if( success ) {
                    print("succes")
                } else {
                    if let error = error {
                        let message = errorMessageForLAErrorCode(error.code)
                        self.showAlertWithTitle("Error", message: message)
                    }
                }
            })
    }
    
    func showAlertWithTitle( title:String, message:String ) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertVC.addAction(okAction)
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

