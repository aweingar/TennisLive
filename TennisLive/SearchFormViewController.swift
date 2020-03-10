import UIKit

class SearchFormViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var DateOfMatch: UILabel!
    
    let controlSlider = SliderControl(frame: CGRect.zero)
    
    var dateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        super.viewDidLoad()
        
        view.addSubview(controlSlider)
        
        controlSlider.addTarget(self, action: #selector(SearchFormViewController.controlSliderValueChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        controlSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: width, height: 31.0)
    }

    @objc func controlSliderValueChanged(controlSlider: SliderControl) {
        print("Slider value: (\(controlSlider.value))")
        
        self.DateOfMatch.font = UIFont.systemFont(ofSize: CGFloat(controlSlider.value * 20.0))
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let searchResultTableViewController = segue.destination as? SearchResultTableViewController,
            let query = dateString {
            searchResultTableViewController.searchParams = SearchParams(date: query)
        }
        
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let strDate = formatter.string(from: datePicker.date)
        dateString = strDate
        
    }
    
}

