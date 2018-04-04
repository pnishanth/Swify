//
//
//  Plist
//
//  Created by Nishanth P.
//  Copyright © 2018 Nishapp. All rights reserved.
//

import Foundation

func writeToPlist() {
var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
var path = paths.stringByAppendingPathComponent("data.plist")
var fileManager = NSFileManager.defaultManager()
if (!(fileManager.fileExistsAtPath(path)))
{
    var bundle : NSString = NSBundle.mainBundle().pathForResource("data", ofType: "plist")
    fileManager.copyItemAtPath(bundle, toPath: path, error:nil)
}
data.setObject(object, forKey: "object")
data.writeToFile(path, atomically: true)
}
