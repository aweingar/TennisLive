import XCTest
@testable import TennisLive

class LiveSummariesTennisLiveTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //LIVE SUMMARIES TESTS
    
    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let LiveSummaryTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LiveSummaryTableViewController")
                as? LiveSummaryTableViewController else {
            XCTFail()
            return
        }
        
        _ = LiveSummaryTableViewController.view

        LiveSummaryTableViewController.searchSportEvent =  [SportEvent3(sport_event: Info3(scheduled: "2019-09-20",
                                                                                tournament: Tournament3(name: "ITF USA F28, Men Singles"),
                                                                                competitors: [Competitors3(name: "Axel Geller", nationality: "Argentina",bracket_number: 5,qualifier: "home"), Competitors3(name: "Ronald Hohmann", nationality: "USA", bracket_number: 7, qualifier: "away")]
    ))]

        guard let TableView = LiveSummaryTableViewController.TableView else {
            XCTFail()
            return
        }

        XCTAssertEqual(1, LiveSummaryTableViewController.searchSportEvent.count)
    }
    
    func testShouldTriggerTennisLiveSumamriesWhenSearchResultTableViewControllerLoads() {
        guard let LiveSummaryTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LiveSummaryTableViewController")
                as? LiveSummaryTableViewController else {
            XCTFail()
            return
        }

        LiveSummaryTableViewController.api = TestApiService()
        LiveSummaryTableViewController.viewDidLoad()
        // Asserts are in the TestApiService implementation, see below.
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let LiveSummaryTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LiveSummaryTableViewController")
                as? LiveSummaryTableViewController else {
            XCTFail()
            return
        }

        var failureCallbackWasCalled = false
        LiveSummaryTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        LiveSummaryTableViewController.api = FailingApiService()
        LiveSummaryTableViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
    }

    class TestApiService: Api {

        func api(host: String) {
        }
        func tennisResults(with params: SearchParams,
        then: ((TennisResults) -> Void)?,
        fail: ((Error) -> Void)?) {
            XCTAssertEqual(params.date, "2019-09-20")
        }
        func tennisSchedules(with params: String,
        then: ((TennisSchedules) -> Void)?,
        fail: ((Error) -> Void)?) {
            XCTAssertEqual(params, "2019-11-14")
        }

        func tennisLiveSummaries(with params: String,
        then: ((TennisSummaries) -> Void)?,
        fail: ((Error) -> Void)?){
            XCTAssertEqual(params, "2019-11-14")
        }
    }

    class FailingApiService: Api {
        func api(host: String) {
        }
        func tennisResults(with params: SearchParams,
                then: ((TennisResults) -> Void)?,
                fail: ((Error) -> Void)?) {
            // For this test, we call the fail function unconditionally because we want to test the error.
            if let callback = fail {
                callback(NSError(domain: "test", code: 0, userInfo: nil))
            }
        }

        func tennisSchedules(with params: String,
                then: ((TennisSchedules) -> Void)?,
                fail: ((Error) -> Void)?) {
            // For this test, we call the fail function unconditionally because we want to test the error.
            if let callback = fail {
                callback(NSError(domain: "test", code: 0, userInfo: nil))
            }
        }

        func tennisLiveSummaries(with params: String,
        then: ((TennisSummaries) -> Void)?,
        fail: ((Error) -> Void)?){
            if let callback = fail {
                callback(NSError(domain: "test", code: 0, userInfo: nil))
            }
        }

}
