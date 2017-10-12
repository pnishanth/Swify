extension MKMapView {
    
    // delta is the zoom factor
    // 2 will zoom out x2
    // .5 will zoom in by x2
    
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;
        
        setRegion(_region, animated: animated)
    }
    
    /**
     - parameter a: coordinate A.
     - parameter b: coordinate B.
     - returns: The distance between the two coordinates.
     */
    static func distanceBetweenLocationCoordinates2D(_ a: CLLocationCoordinate2D, b: CLLocationCoordinate2D) -> CLLocationDistance {
        
        let locA: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let locB: CLLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        
        return locA.distance(from: locB)
    }
    
}

/* Usage
 
 MKMapView.setZoomByDelta(delta:2,animated:Bool) => ZoomOut
 MKMapView.setZoomByDelta(delta:0.5,animated:Bool) => ZoomIn

*/
