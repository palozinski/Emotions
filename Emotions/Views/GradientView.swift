import UIKit

@IBDesignable final class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor? {
        didSet {
            render()
        }
    }
    
    @IBInspectable var endColor: UIColor? {
        didSet {
            render()
        }
    }
    
    @IBInspectable var vertical: Bool = true {
        didSet {
            render()
        }
    }
    
    private var startPoint: CGPoint {
        return vertical ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0, y: 0.5)
    }
    
    private var endPoint: CGPoint {
        return vertical ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 1, y: 0.5)
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    private func render() {
        guard let gradientLayer = layer as? CAGradientLayer,
            let startColor = startColor,
            let endColor = endColor else {
                return
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
