//
//
//  File
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//



import Foundation

public extension NSFileManager {
    
    /**
     Will return size of a file in given path. If file does not exists will return 0.
     
     :param: path is a file path string
     
     :returns: File size
     */
    func fileSizeAtPath(path: String) -> Int {
        var size: UInt64 = 0
        var error: NSError?
        var attributes: NSDictionary? = NSFileManager.defaultManager().attributesOfItemAtPath(path, error: &error)
        
        if let dict = attributes {
            size = dict.fileSize()
            return Int(size)
        }
        
        return 0
    }
}
