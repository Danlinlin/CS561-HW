import XCTest
import MyLibrary
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    func testFilePath(){
        let filePath = Bundle.module.path(forResource: "data", ofType: "json")
        XCTAssertNotNil(filePath)
    }
    
    func testIsWeatherCorrect() throws{
        //Given
        //Weather data in data.json
        //option 1
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)

        //option 2:
//        let jsonString = """
//{"coord":{"lon":-123.262,"lat":44.5646},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":60.01,"feels_like":58.62,"temp_min":55.94,"temp_max":64.24,"pressure":1011,"humidity":62},"visibility":10000,"wind":{"speed":1.01,"deg":338,"gust":3},"clouds":{"all":0},"dt":1665903655,"sys":{"type":2,"id":2040223,"country":"US","sunrise":1665930569,"sunset":1665970039},"timezone":-25200,"id":5720727,"name":"Corvallis","cod":200}
//"""

        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        //When
        //Get the temperature
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)

        //Then
        //Check the temprature is equal to temp in data.json.
        XCTAssertEqual(weather.main.temp, 60.01)

    }
}
