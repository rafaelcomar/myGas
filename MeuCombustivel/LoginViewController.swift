//
//  LoginViewController.swift
//  MeuCombustivel
//
//  Created by alunor17 on 29/04/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var senhaTxtField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if let authUser = user {
                print("Logged In \(authUser.email)")
                self.performSegue(withIdentifier: "LOGIN_SEGUE", sender: self)
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        FIRAuth.auth()?.signIn(withEmail: self.emailTxtField.text!, password: self.senhaTxtField.text!) { (user, error) in
            
            
            print("Login \(error?.localizedDescription)")
        }

    }
    @IBAction func btnCadastro(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: self.emailTxtField.text!, password: self.senhaTxtField.text!) { (user, error) in
            if let errorResult = error {
                self.present(buildAlertController(withMessage: errorResult.localizedDescription), animated: true, completion: nil)
            }

            print("Created \(error?.localizedDescription)")
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
