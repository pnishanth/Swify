//
//
//  UITextField
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import UIKit

public extension UITextField {
    
        //set cornerRadius
        func cornerRadius(){
            self.layoutIfNeeded()
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
        
        //set bordercolor
        func borderColor(){
            self.layer.borderColor = TEXTFIELD_BORDER_COLOR.cgColor
            self.layer.borderWidth = 1.0
        }
        
        //set borderWidth
        func borderWidth(size:CGFloat){
            self.layer.borderWidth = size
        }
        
        //check textfield is blank
        func blank() -> Bool{
            let strTrimmed = self.text!.trim()//get trimmed string
            if(strTrimmed.characters.count == 0)//check textfield is nil or not ,if nil then return false
            {
                return true
            }
            return false
        }
        
        //set begginning space - left space
        func setLeftPadding(paddingValue:CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: self.frame.size.height))
            self.leftViewMode = .always
            self.leftView = paddingView
        }
        
        //set end of space
        func setRightPadding(paddingValue:CGFloat){
            let paddingView = UIView(frame: CGRect(x: (self.frame.size.width - paddingValue), y: 0, width: paddingValue, height: self.frame.size.height))
            self.rightViewMode = .always
            self.rightView = paddingView
        }
    
}
