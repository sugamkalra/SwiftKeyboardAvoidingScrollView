//
//  KeyboardAvoidingScrollView.swift
//  SwiftyKeyboardAvoidingScrollView
//
//  Created by Sugam Kalra on 11/12/15.
//  Copyright © 2015 Sugam Kalra. All rights reserved.
//

import UIKit

/**
* KeyboardAvoidingScrollView
* The scrollview that will change its content inset when the keyboard is appearing
*
* @author Sugam
* @version 1.0
*/
class KeyboardAvoidingScrollView: UIScrollView {
    
    /// the original content inset
    var oriContentInset: UIEdgeInsets?
    
    /**
     Init with frame
        
     - Parameter frame: the frame
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    /**
     Init with a decoder
         
     - Parameter coder: a decoder
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    /**
     Initial setup
     */
    func setup() {
        registerForKeyboardNotifications()
    }
    
    /**
     The action called when there will be a move to a new superview
     
     - Parameter newSuperView: the super view
     */
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        if newSuperview == nil {
            unregisterForKeyboardNotifications()
        }
    }
    
    /**
     Register keyboard notifications
     */
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
     Unregister keyboard notifications
     */
    func unregisterForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
     The selector that will be called when the keyboard was shown
     
     - Parameter notification: the notification
     */
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        if var kbRect = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            kbRect = self.convertRect(kbRect, fromView: nil)
            oriContentInset = self.contentInset
            
            // set the new content inset
            let contentInset = UIEdgeInsets(
                top: oriContentInset!.top,
                left: oriContentInset!.left,
                bottom: kbRect.size.height,
                right: oriContentInset!.right)
            self.contentInset = contentInset
            self.scrollIndicatorInsets = contentInset
        }
    }
    
    /**
     The selector that will be called when the keyboard will be hidden
     
     - Parameter notification: the notification
     */
    func keyboardWillBeHidden(notification: NSNotification) {
        
        // reset the content inset to original
        if let oriContentInset = oriContentInset {
            self.contentInset = oriContentInset
            self.scrollIndicatorInsets = oriContentInset
        }
    }
    
}