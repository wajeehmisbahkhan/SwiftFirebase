//
//  LoginViewController.swift
//  SwiftFirebase
//
//  Created by Wajeeh Misbah Khan on 17/09/2019.
//  Copyright © 2019 Telic Solutions. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var emailTextField: UITextField!
  
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  
  @IBOutlet weak var errorLabel: UILabel!
  
  var email = "";
  var password = "";
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
  
    func setUpElements() {
      
      // Hide error
      errorLabel.alpha = 0;
      // Style text fields
      Utilities.styleTextField(emailTextField);
      Utilities.styleTextField(passwordTextField);
      
      
    }
  
  func validateFields() -> String? {
    
    // Check all fields are filled
    if email == "" || password == "" {
      return "Please fill all fields."
    }
    
    // No errors
    return nil;
  }
  
  @IBAction func loginTapped(_ sender: Any) {
    email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);
    password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);
    
    // Validate fields
    let error = validateFields();
    if (error != nil) {
      showError(error!);
      return;
    }
    
    
    
    
    // Sign in
    Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
      if (error != nil) {
        self.showError(error!.localizedDescription);
        return;
      }
      self.transitionToHomeScreen();
    }
  }
  
  func showError(_ error: String) {
    errorLabel.text = error;
    errorLabel.alpha = 1;
  }
  
  func transitionToHomeScreen() {
    let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeStoryBoard) as? HomeViewController;
    
    view.window?.rootViewController = homeViewController;
    view.window?.makeKeyAndVisible();
  }
  
}
