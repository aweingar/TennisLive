import XCTest
@testable import TennisLive

class TennisLiveTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //RESULTS TESTS
    
    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
            guard let SearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "SearchResultTableViewController")
                    as? SearchResultTableViewController else {
                XCTFail()
                return
            }
        
        _ = SearchResultTableViewController.view

            SearchResultTableViewController.searchSportEvent =  [SportEvent(sport_event: Info(scheduled: "2019-09-20", tournament: Tournament(name:"ITF USA F28, Men Singles"), competitors: [Competitors(name: "Axel Geller",
                                                                                                                                                                                          nationality: "Argentina",
                                                                                                                                                                                          bracket_number: 5,
                                                                                                                                                                                          qualifier: "home"),
                                                                                                                                                                              Competitors(name: "Ronald Hohmann",
                                                                                                                                                                                          nationality: "USA",
                                                                                                                                                                                          bracket_number: 7,
                                                                                                                                                                                          qualifier: "away")
                ]), sport_event_status: Score(home_score: 1, away_score: 2))
            ]

        guard SearchResultTableViewController.TableView != nil else {
                XCTFail()
                return
            }
        
            XCTAssertEqual(1, SearchResultTableViewController.searchSportEvent.count)
        }

        func testShouldTriggerTennisResultsWhenSearchResultTableViewControllerLoads() {
            guard let SearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "SearchResultTableViewController")
                    as? SearchResultTableViewController else {
                XCTFail()
                return
            }

            SearchResultTableViewController.api = TestApiService()
            SearchResultTableViewController.searchParams = SearchParams(date: "2019-09-20")
            SearchResultTableViewController.viewDidLoad()
            // Asserts are in the TestApiService implementation, see below.
        }

        func testShouldDisplayAlertWhenAPICallFails() {
            guard let SearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "SearchResultTableViewController")
                    as? SearchResultTableViewController else {
                XCTFail()
                return
            }

            var failureCallbackWasCalled = false
            SearchResultTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }

            SearchResultTableViewController.api = FailingApiService()
            SearchResultTableViewController.searchParams = SearchParams(date: "2019-09-20")
            SearchResultTableViewController.viewDidLoad()

            XCTAssert(failureCallbackWasCalled)
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
}

