import XCTest
@testable import TennisLive

class SchedulesTennisLiveTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //SCHEDULES TESTS
    
    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let ViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController")
                as? ViewController else {
            XCTFail()
            return
        }
        
        _ = ViewController.view

        ViewController.searchSportEvent =  [
            (SportEvent2(scheduled: "2019-09-20",
            tournament: Tournament2(name: "ITF USA F28, Men Singles")
            ))
        ]

        guard ViewController.TableView != nil else {
            XCTFail()
            return
        }

        XCTAssertEqual(1, ViewController.searchSportEvent.count)
    }
    
    func testShouldTriggerTennisSchedulesWhenSearchResultTableViewControllerLoads() {
        guard let ViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController")
                as? ViewController else {
            XCTFail()
            return
        }

        ViewController.api = TestApiService()
        ViewController.viewDidLoad()
        // Asserts are in the TestApiService implementation, see below.
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let ViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController")
                as? ViewController else {
            XCTFail()
            return
        }

        var failureCallbackWasCalled = false
        ViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        ViewController.api = FailingApiService()
        ViewController.viewDidLoad()

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
