//
//
//  Bool
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import UIKit

public extension Bool {
    
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }
    
}
