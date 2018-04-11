//
//
//  Crypto Functions
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

let testStr = "Hello, world!"
guard let baseBytes = testStr.encode(.base64) else {
    return
}

String(validatingUTF8: baseBytes) == "SGVsbG8sIHdvcmxkIQ==="

guard let unBase = baseBytes.decode(.base64) else {
    return
}

String(validatingUTF8: unBase) == testStr
