private func callNumber(phoneNumber:String) {
    
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}
