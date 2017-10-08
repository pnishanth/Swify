//
//
//  Share App
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//

func share()
{

let firstActivityItem = "TEXT"
let secondActivityItem : NSURL = NSURL(string: "http//:url")!
    
// Image
let image : UIImage = UIImage(named: "image.jpg")!

let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

// Popover
activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

// Remove the arrow of the popover to show in iPad
activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

//Exclude
activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
]

self.presentViewController(activityViewController, animated: true, completion: nil)
}
