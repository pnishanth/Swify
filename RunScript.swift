//
//
//  Script
//
//  Created by Nishanth P.
//  Copyright © 2018 Nishapp. All rights reserved.
//

// Check jenkins1kasklajdasadsjbakjxzxz

import Foundation

extension String {
    func executeScript() -> String {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", String(format:"%@", self)]
        task.standardOutput = pipe
        let file = pipe.fileHandleForReading
        task.launch()
        if let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue) {
            return result as String
        }
        else {
            return "Error executing command"
        }
    }
}

print("echo Executed".executeScript()) //prints Executed.
