//
//  SignupViewController.swift
//  SwiftFirebase
//
//  Created by Wajeeh Misbah Khan on 17/09/2019.
//  Copyright © 2019 Telic Solutions. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {

  @IBOutlet weak var firstNameTextField: UITextField!
  
  @IBOutlet weak var lastNameTextField: UITextField!
  
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var signUpButton: UIButton!
  
  @IBOutlet weak var errorLabel: UILabel!
  
  var firstName = "";
  var lastName = "";
  var email = "";
  var password = "";
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpElements()

        // Do any additional setup after loading the view.
    }
  
  func setUpElements() {
    
    // Hide error
    errorLabel.alpha = 0;
    
    Utilities.styleTextField(firstNameTextField);
    
    Utilities.styleTextField(lastNameTextField);
    
    Utilities.styleTextField(emailTextField);
    
    Utilities.styleTextField(passwordTextField);
    
  }
  
  func validateFields() -> String? {
    
    // Check all fields are filled
    if firstName == "" || lastName == "" || email == "" || password == "" {
      return "Please fill all fields."
    }
    
    if (Utilities.isPasswordValid(password)) {
      return "Password is too weak. Must have atleast 8 characters, contain a special character and a number"
    }
    
    // No errors
    return nil;
  }
  
  
  @IBAction func signUpTapped(_ sender: Any) {
    
    // Store values of fields
    firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);
    lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);
    email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);
    password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines);

    // Validate fields
    let error = validateFields();
    if (error != nil) {
      showError(error!);
      return;
    }
    
    
    
    
    // Add user
    Auth.auth().createUser(withEmail: email, password: password, completion: { (result, err) in
      if (err != nil) {
        self.showError("Error creating user!\n" + err!.localizedDescription);
        return
      }
      
      // Store first and last name
      let db = Firestore.firestore();
      db.collection("users").addDocument(data: [
        "firstName": self.firstName,
        "lastName": self.lastName,
        "uid": result!.user.uid
        ], completion: {(err) in
          if (err != nil) {
            self.showError("Error saving data!\n" + err!.localizedDescription);
            return;
          }
          self.transitionToHomeScreen();
        })
      
    })
    
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
