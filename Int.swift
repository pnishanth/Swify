//
//
//  Int
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Foundation

public extension Int {
    
    // MARK: Working with numbers
    
    /**
     :returns: *true* if self is even number
     */
    var isEven: Bool {
        return ( self % 2 == 0 )
    }
    
    /**
     :returns: *true* if self is odd number
     */
    var isOdd: Bool {
        return ( self % 2 != 0 )
    }
    
    /**
     :returns: *true* if self is positive number
     */
    var isPositive: Bool {
        return ( self > 0 )
    }
    
    /**
     :returns: *true* if self is negative number
     */
    var isNegative: Bool {
        return ( self < 0 )
    }
    
    /**
     :returns: *true* if self is zero
     */
    var isZero: Bool {
        return ( self == 0 )
    }
    
    /**
     :returns: *true* if self is positive or zero
     */
    var isPOZ: Bool {
        return ( self.isPositive || self.isZero )
    }
    
    /**
     :returns: cast self to Double
     */
    func double() -> Double {
        return Double(self)
    }
    
    /**
     :returns: cast self to Float
     */
    func float() -> Float {
        return Float(self)
    }
    
    // MARK: Useful
    
    /**
     This method will repeat *closure* n times. Possible way of usage:
     
     12.times { ... do something ... }
     
     :param: closure is a given code that will be invoked
     */
    func times(closure: () -> ()) {
        for _ in 0 ..< self {
            closure()
        }
    }
    
    func times (iterator: () -> Void) {
        for _ in 0..self {
            iterator()
        }
}



