@IBDesignable class CustomView: UIView {
    
    @IBInspectable var fillColor : UIColor = UIColor.clear {
        didSet {
            layer.backgroundColor = fillColor.cgColor
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var maskToBounds : Bool = true {
        didSet{
            layer.masksToBounds = maskToBounds
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
