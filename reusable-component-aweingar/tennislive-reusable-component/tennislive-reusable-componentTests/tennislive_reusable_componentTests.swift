import UIKit

@IBDesignable class SliderControl: UIControl {
    // The component's model.
    var currentTouch: UITouch? = nil


    // We will manipulate a drawing layer as the component's "view."
    var sliderLayer = CALayer()

    // The "inspectable" properties of the view will allow editing via Xcode!
    @IBInspectable var trackTintColor: UIColor = .white {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable var thumbTintColor: UIColor = .white {
        didSet {
            layoutSubviews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        layoutSubviews()
    }

    override func layoutSubviews() {
        sliderLayer.removeFromSuperlayer()
        sliderLayer.borderColor = trackTintColor.cgColor
        sliderLayer.borderColor = thumbTintColor.cgColor
        sliderLayer.frame = bounds
        layer.addSublayer(sliderLayer)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        currentTouch = touch
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // Make sure we are following the same finger.
        if touch != currentTouch {
            return false
        }


        // Model changed, so we update the view and send out updates to other controllers.
        setNeedsDisplay()
        sendActions(for: .valueChanged)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if touch == currentTouch {
            // Release the touch, indicating the end of this particular touch sequence.
            cancelTracking(with: event)
        }
    }

    override func cancelTracking(with event: UIEvent?) {
        currentTouch = nil
    }
}
