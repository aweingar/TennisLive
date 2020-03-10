import UIKit
import QuartzCore

class SliderControl: UIControl {
    
    var minimumValue = 0.0
    var maximumValue = 1.0
    var value = 0.5

    
    let trackLayer = SliderTrackLayer()
    let thumbLayer = SliderThumbLayer()
    
    var previousLocation = CGPoint()
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        trackLayer.controlSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        thumbLayer.sliderControl = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)
    }
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0)
    var thumbTintColor = UIColor.white

    var curvaceousness : CGFloat = 1.0

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let thumbCenter = CGFloat(positionForValue(value: value))
        
        thumbLayer.frame = CGRect(x: thumbCenter - thumbWidth / 2.0, y: 0.0,
          width: thumbWidth, height: thumbWidth)
        thumbLayer.setNeedsDisplay()
    }

    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)

        // Hit test the thumb layers
        if thumbLayer.frame.contains(previousLocation) {
           thumbLayer.highlighted = true
        }
        return thumbLayer.highlighted
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previousLocation = location

        // 2. Update the values
        if thumbLayer.highlighted {
            value += deltaValue
        }

        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        updateLayerFrames()

        CATransaction.commit()

        sendActions(for: .valueChanged)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbLayer.highlighted = false
    }
}
