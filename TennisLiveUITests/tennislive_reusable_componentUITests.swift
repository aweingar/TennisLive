import XCTest
@testable import tennislive_reusable_component

class SliderTests: XCTestCase {

        override func setUp() {
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }

        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }
        
        func testSliderControlStartsWithCorrectInitialValues() {
            let slider = SliderControl()
            XCTAssertEqual(slider.minimumValue, 0, "Initial minimum should be zero")
            XCTAssertEqual(slider.maximumValue, 1, "Initial maximum should be one")
            XCTAssertEqual(slider.value, 0.5, "Initial thumb value should be zero")
            XCTAssertNotNil(slider.trackLayer, "Thumb should have an image view")
        }
        
        func testSliderControlUpdatesEditablePropertiesCorrectly() {
            let slider = SliderControl()
            
            slider.trackTintColor = .white
    
            XCTAssertEqual(slider.trackTintColor, UIColor.white, "Color should be black")
    
            XCTAssertEqual(slider.trackHighlightTintColor, UIColor.red, "Color should be red")
            
            XCTAssertEqual(slider.thumbTintColor, UIColor.white, "Color should be white")
        
            XCTAssertEqual(slider.minimumValue, 0, "Background color should go to layer")
            XCTAssertEqual(slider.maximumValue, 100, "Background color should go to layer")
        }
        
        func testSliderControlStopsTrackingWhenTouchChanges() { //this isnt working properly
            let slider = SliderControl()

            // SwivelControl doesn't use the event argument so we can skip it.
            XCTAssertFalse(slider.beginTracking(
                MockTouch(withMockLocation: CGPoint(x: 20, y: 0)), with: nil), "Initial track should return true")

            XCTAssertFalse(slider.continueTracking(
                MockTouch(withMockLocation: CGPoint(x: 10, y: 0)), with: nil), "Track movement should return true")
        }
    }

    class MockTouch: UITouch {
        var mockLocation: CGPoint = CGPoint(x: 0, y: 0)

        init(withMockLocation location: CGPoint) {
            mockLocation = location
        }

        override func location(in view: UIView?) -> CGPoint {
            return mockLocation
        }
    }
