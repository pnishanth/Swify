//
//
//  UIView
//
//  Created by Nishanth P.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import UIKit

public extension UIView {
    
    // MARK: Easily get frames parameters
    
    /**
     :returns: Current view width
     */
    var width: CGFloat {
        return self.frame.size.width
    }
    
    /**
     :returns: Current view height
     */
    var height: CGFloat {
        return self.frame.size.height
    }
    
    /**
     :returns: Current view x position
     */
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    /**
     :returns: Current view y position
     */
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    /**
     :returns: Current view center x position
     */
    var centerX: CGFloat {
        return self.center.x
    }
    
    /**
     :returns: Current view center y position
     */
    var centerY: CGFloat {
        return self.center.y
    }
    
    // MARK: Easily update frames parameters
    
    /**
     Update frames width with a given value
     */
    func setWidth(width: CGFloat) {
        self.frame.size.width = width
    }
    
    /**
     Update frames height with a given value
     */
    func setHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    /**
     Update frames origin x with a given value
     */
    func setX(x: CGFloat) {
        self.frame.origin.x = x
    }
    
    /**
     Update frames origin y with a given value
     */
    func setY(y: CGFloat) {
        self.frame.origin.y = y
    }
    
    /**
     Update frames center x with a given value
     */
    func setCenterX(x: CGFloat) {
        self.center.x = x
    }
    
    /**
     Update frames center y with a given value
     */
    func setCenterY(y: CGFloat) {
        self.center.y = y
    }
    
    func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
    
}

extension UIStackView {

    public convenience init(distribution: UIStackViewDistribution,
                            alignment: UIStackViewAlignment,
                            axis: UILayoutConstraintAxis,
                            spacing: CGFloat = 0) {
        self.init()
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
    

    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
}
