//
//
//  UILabel
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import UIKit
    
public extension UILabel {

        func setStrikethrough(text:String, color:UIColor = UIColor.blackColor()) {
            let attributedText = NSAttributedString(string: text , attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue, NSStrikethroughColorAttributeName: color])
            self.attributedText = attributedText
        }
        
        func setLineHeight(lineHeight: CGFloat) {
            let text = self.text
            if let text = text {
                let attributeString = NSMutableAttributedString(string: text)
                let style = NSMutableParagraphStyle()
                
                style.lineSpacing = lineHeight
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
                self.attributedText = attributeString
            }
            
         }

        func set(text _text: String?, duration: TimeInterval) {
            UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
                self.text = _text
            }, completion: nil)
    }
    
    }
    

