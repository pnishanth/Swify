public extension UIColor{
    
    func isEqualToColor(color: UIColor, withTolerance tolerance: CGFloat = 0.0) -> Bool{
        
        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return
            fabs(r1 - r2) <= tolerance &&
                fabs(g1 - g2) <= tolerance &&
                fabs(b1 - b2) <= tolerance &&
                fabs(a1 - a2) <= tolerance
    }
    
}

if Color1.isEqualToColor(UIColor.whiteColor(), /* optional */ withTolerance: 0.0){
    //Color 1 compared to whiteColor
    //Do Something
    
}
