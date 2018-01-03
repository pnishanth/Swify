//
//
//  Alamofire
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

// Alamofire upload

//S

Alamofire.upload(
    multipartFormData: { multipartFormData in
        multipartFormData.append(imageData,
                                 withName: "imagefile",
                                 fileName: "image.jpg",
                                 mimeType: "image/jpeg")
},
    to: "http://api.imagga.com/v1/content",
    headers: ["Authorization": "Basic xxx"],
    encodingCompletion: { encodingResult in
}
)
