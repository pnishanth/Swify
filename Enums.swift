//
//  ViewController.swift
//  Optionals
//
//  Created by Nishanth P on 7/4/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import Foundation

enum Optional<T> {
    case none
    case something(T)
}

//Error Handling

enum APIError : Error {
    // Can't connect to the server (maybe offline?)
    case ConnectionError(error: NSError)
    // The server responded with a non 200 status code
    case ServerError(statusCode: Int, error: NSError)
    // We got no data (0 bytes) back from the server
    case NoDataError
    // The server response can't be converted from JSON to a Dictionary
    case JSONSerializationError(error: Error)
    // The Argo decoding Failed
    case JSONMappingError(converstionError: DecodeError)
}
