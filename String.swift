//
//
//  String
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Foundation

extension String {
    
    /**
     :returns: Length of a string
     */
    func length() -> Int {
        return count(self)
    }
    
    /**
     :returns: String without first and last whitespaces and new line characters
     */
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    /**
     :returns: Substring in current string starting at position `location` with `length`
     */
    func substring(location: Int, length: Int) -> String! {
        var location = location
        if location >= self.length() {
            return ""
        }
        
        while location < 0 {
            location += self.length()
        }
        
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }
    
    /**
     :returns: Character at `index` position
     */
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    /**
     :returns: Location of a substring
     */
    func location(substring: String) -> Int {
        return (self as NSString).rangeOfString(substring).location
    }
    
    /**
     :returns: *true* if string contains substring
     */
    func contains(substring: String) -> Bool {
        return (self as NSString).containsString(substring)
    }
    
    /**
     :returns: *true* string is numeric string
     */
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
    
}
