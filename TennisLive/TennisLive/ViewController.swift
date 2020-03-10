import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let REUSE_IDENTIFIER = "TableViewCell"
    
    @IBOutlet weak var TableView: UITableView!
    
    
    // We check for the presence of a "UI-TESTING" argument to see if we are in a test, and if so we
    // instantiate a mock service rather than the real one. In addition, we declare the Api as a var so
    // that we can reassign it in tests or mockups.
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
        PlaceholderApiService() : RealApiService()
    
    // Same strategy for the network failure callback function.
    // Yes, we are devoting some extra code here _solely_ to accommodate testing, but it is worth it.
    var failureCallback: ((Error) -> Void)?
    
    var searchSportEvent: [SportEvent2] = []
    
    var selectedRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        api.api(host: "https://api.sportradar.com/tennis-t2/en/schedules/")
        api.tennisSchedules(with: result, then: display, fail: failureCallback ?? report)
    }
    
    func numberOfSections (in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSportEvent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
                
                as! SearchResultTableViewCell
            
            cell.schedulesDateText.text = "Date: ".appending(String(searchSportEvent[indexPath.row].scheduled))
            
            cell.schedulesTournamentText.text = "Match: ".appending(String( searchSportEvent[indexPath.row].self.tournament.name))
            
            return cell
    }
    
    private func display(tennisSchedules: TennisSchedules) {
        searchSportEvent = tennisSchedules.sport_events
        TableView.reloadData()
    }
    
    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
                                      message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


