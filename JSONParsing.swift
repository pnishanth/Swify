//
//
//  JSONParsing
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

do {
    if let todoJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
        let todo = Todo(json: todoJSON) {
        // created a TODO object
        completionHandler(todo, nil)
    } else {
        // couldn't create a todo object from the JSON
        let error = BackendError.objectSerialization(reason: "Couldn't create a todo object from the JSON")
        completionHandler(nil, error)
    }
} catch {
    // error trying to convert the data to JSON using JSONSerialization.jsonObject
    completionHandler(nil, error)
    return
}
