func cropImage(image: UIImage, toRect: CGRect) -> UIImage? {
    // Cropping is available trhough CGGraphics
    let cgImage :CGImage! = image.cgImage
    let croppedCGImage: CGImage! = cgImage.cropping(to: toRect)
    
    return UIImage(cgImage: croppedCGImage)
}
