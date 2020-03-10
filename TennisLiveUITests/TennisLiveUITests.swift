import XCTest

class TennisLiveUITests: XCTestCase {

let app = XCUIApplication()

    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        // UI tests can’t see the code so we need to replicate the testing key here as a literal.
        app.launchArguments.append("UI_TESTING")

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabBarHomeButton() {
        let button = app.tabBars.firstMatch.buttons.element(boundBy: 0)
        button.tap()
        XCTAssert(button.isEnabled)
    }

    func testTabBarCalendarButton() {
        let button = app.tabBars.firstMatch.buttons.element(boundBy: 1)
        button.tap()
        XCTAssert(button.isEnabled)
    }

    func testTabBarPlayButton() {
        let button = app.tabBars.firstMatch.buttons.element(boundBy: 2)
        XCTAssert(button.isEnabled)
        button.tap()
    }

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    func testDatePicker() {
        testTabBarCalendarButton()
        
         let datePick = XCUIApplication().datePickers
        datePick.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "June")
         datePick.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "1")
         datePick.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2015")
    }
    
    func testSearchButtonShouldBeEnabledWhenTheSearchFieldIsNotBlank() {
        testDatePicker()

        let searchButton = app.buttons["Search"]
        XCTAssert(searchButton.isEnabled)
    }

    func testShouldPopulateTheTableViewWhenSearchResultsArrive() {
        testDatePicker()

        let searchButton = app.buttons["Search"]
        searchButton.tap()

        let tableView = app.tables["resultTableView"]
        XCTAssertEqual(1, tableView.cells.count)
    }
}

