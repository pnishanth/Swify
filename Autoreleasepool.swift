//
//
//  Autoreleasepool
//
//  Created by Nishanth P.
//  Copyright © 2018 Nishapp. All rights reserved.
//

import Foundation

func useManyImages() {
    let filename = pathForResourceInBundle
    
    for _ in 0 ..< 5 {
        autoreleasepool { // USE AUTORELEASEPOOL for better Memory mgmt.
            for _ in 0 ..< 1000 {
                let image = NSImage(contentsOfFile: filename)
            }
        }
    }
}
