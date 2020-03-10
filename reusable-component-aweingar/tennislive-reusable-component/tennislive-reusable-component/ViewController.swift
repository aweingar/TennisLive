import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var FontSizeChanged: UILabel!
   
    let controlSlider = SliderControl(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(controlSlider)
        
        controlSlider.addTarget(self, action: #selector(ViewController.controlSliderValueChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        controlSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: width, height: 31.0)
    }

    @objc func controlSliderValueChanged(controlSlider: SliderControl) {
        print("Slider value: (\(controlSlider.value))")
        
        self.FontSizeChanged.font = UIFont.systemFont(ofSize: CGFloat(controlSlider.value * 20.0))
    }
}
