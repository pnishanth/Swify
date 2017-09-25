//
//  ViewController.swift
//  Image Compare
//
//  Created by Nishanth P on 9/25/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//



//USAGE

let image1 = UIImage(named: "Image1.png")
let image2 = UIImage(named: "Image2.png")


extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = UIImagePNGRepresentation(self)!
        let data2: NSData = UIImagePNGRepresentation(image)!
        return data1.isEqual(data2)
    }
    
    func compareImages(image1: UIImage, image2: UIImage) -> Double? {
        guard let data1 = pixelValues(fromCGImage: image1.cgImage),
            let data2 = pixelValues(fromCGImage: image2.cgImage),
            data1.count == data2.count else {
                return nil
        }
        
        let width = Double(image1.size.width)
        let height = Double(image1.size.height)
        
        return zip(data1, data2)
            .enumerated()
            .reduce(0.0) {
                $1.offset % 4 == 3 ? $0 : $0 + abs(Double($1.element.0) - Double($1.element.1))
            }
            * 100 / (width * height * 3.0) / 255.0
    }
}



compareImages(image1: image1, image2: image2)


extension CGImage {
    
    func pixelValues(fromCGImage imageRef: CGImage?) -> [UInt8]?
    {
        var width = 0
        var height = 0
        var pixelValues: [UInt8]?
        
        if let imageRef = imageRef {
            width = imageRef.width
            height = imageRef.height
            let bitsPerComponent = imageRef.bitsPerComponent
            let bytesPerRow = imageRef.bytesPerRow
            let totalBytes = height * bytesPerRow
            let bitmapInfo = imageRef.bitmapInfo
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            var intensities = [UInt8](repeating: 0, count: totalBytes)
            
            let contextRef = CGContext(data: &intensities,
                                       width: width,
                                       height: height,
                                       bitsPerComponent: bitsPerComponent,
                                       bytesPerRow: bytesPerRow,
                                       space: colorSpace,
                                       bitmapInfo: bitmapInfo.rawValue)
            contextRef?.draw(imageRef, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
            
            pixelValues = intensities
        }
        
        return pixelValues
    }

    
    func doImagesHaveSameMeta(image1:CGImage, image2:CGImage) -> Bool {
        if CGImageGetWidth(image1) != CGImageGetWidth(image2) {
            return false
        }
        
        if CGImageGetHeight(image1) != CGImageGetHeight(image2) {
            return false
        }
        
        if CGImageGetBitsPerComponent(image1) != CGImageGetBitsPerComponent(image2) {
            return false
        }
        
        if CGImageGetBytesPerRow(image1) != CGImageGetBytesPerRow(image2) {
            return false
        }
        
        if CGImageGetBitsPerPixel(image1) != CGImageGetBitsPerPixel(image2) {
            return false
        }
        
        return true
    }

    
}

