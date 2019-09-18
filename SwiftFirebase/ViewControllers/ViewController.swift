//
//  ViewController.swift
//  SwiftFirebase
//
//  Created by Wajeeh Misbah Khan on 16/09/2019.
//  Copyright © 2019 Telic Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var signUpButton: UIButton!
  
  
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setUpElements();
  }
  
  func setUpElements() {
    Utilities.styleFilledButton(signUpButton);
    Utilities.styleHollowButton(loginButton);
  }


}

