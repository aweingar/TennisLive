import UIKit
import QuartzCore

class SliderTrackLayer: CALayer {
    weak var controlSlider: SliderControl?
    
    override func draw(in ctx: CGContext) {
        if let slider = controlSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let valuePosition = CGFloat(slider.positionForValue(value: slider.value))
            let rect = CGRect(x: 0.0, y: 0.0, width: valuePosition, height: bounds.height)
            ctx.fill(rect)
        }
    }
}
