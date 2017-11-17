//
//
//  Array
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import Foundation

extension Array {
    
    // Will remove object from an array. If there are more than one the same object in array it will remove it also.
     
     //:param: object is an object that should conform *Equatable* protocol.
    
    mutating func removeObject<U: Equatable>(object: U) {
        var index: [Int] = []
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index.append(idx)
                    
                }
            }
        }
        
        var counter: Int = 0
        for i in index {
            self.removeAtIndex(i - counter)
            counter++
        }
    }
    
    
    func sort() -> [HighScoreEntry] {
            return sort { $0.score < $1.score }
        }
    
    /**
     Will return *true* if array contains object. Object should conform *Equatable* protocol.
     
     :param: object is a given object that will be compared to other objects in our array
     
     :returns: *true* is array contains object
     */
    func contains<T where T : Equatable>(object: T) -> Bool {
        return self.filter({$0 as? T == object}).count > 0
    }
}
