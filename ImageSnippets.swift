//
//  ViewController.swift
//  ImageSnipets
//
//  Created by Nishanth P on 9/25/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//



func getScreenShotAlbumCount(){
    
let albumsPhoto:PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
albumsPhoto.enumerateObjects({(collection, index, object) in
    if collection.localizedTitle == "Screenshots"{
        let photoInAlbum = PHAsset.fetchAssets(in: collection, options: nil)
        print(photoInAlbum.count)
    }
})
    
}

func CreateThumbnailImage(data: NSData, imageSize:Int) -> CGImageRef! {
    var thumbnailSize: CFNumberRef = 0
    
    // Create an image source from NSData; no options.
    if let imgSource = CGImageSourceCreateWithData(data, nil) {
        
        // Set up the thumbnail options.
        var options = [
            kCGImageSourceCreateThumbnailWithTransform as NSString : kCFBooleanTrue,
            kCGImageSourceCreateThumbnailFromImageIfAbsent as NSString : kCFBooleanTrue,
            kCGImageSourceThumbnailMaxPixelSize as NSString : imageSize
        ]
        
        // Create the thumbnail image using the specified options.
        if let image = CGImageSourceCreateThumbnailAtIndex(imgSource, 0, options) {
            return image
        } else {
            println("Thumbnail image not created from image source.")
        }
    } else {
        println("Image source is NULL.")
    }
    
    return nil
}


func getAssetThumbnail(asset: PHAsset, size: CGFloat) -> UIImage {
    let retinaScale = UIScreen.main.scale
    let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)
    let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
    let square = CGRect(x:0, y: 0,width: CGFloat(cropSizeLength),height: CGFloat(cropSizeLength))
    let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    var thumbnail = UIImage()
    options.isSynchronous = true
    options.deliveryMode = .highQualityFormat
    options.resizeMode = .exact
    options.normalizedCropRect = cropRect
    manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}
