//
//  ViewController.swift
//  SwiftyKeyboardAvoidingScrollView
//
//  Created by Sugam Kalra on 11/12/15.
//  Copyright © 2015 Sugam Kalra. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        

    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if(textField == usernameField)
        {
            usernameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }
        else
        {
            passwordField.resignFirstResponder()
        }
                
        return false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

