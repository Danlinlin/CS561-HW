//
//  File.swift
//  
//
//  Created by Danlin Song on 10/15/22.
//

import Foundation
import XCTest
import MyLibrary
@testable import MyLibrary

final class WeatherServiceImplIntegrationTest: XCTestCase{
    
    func testGetTemperature() async throws{
        //Given
        //Create a weather service
        let weatherService = WeatherServiceImpl()
        
        //When
        //Get the tempture
        let temp = try await weatherService.getTemperature()
        
        //Then
        //Check the temprature is what you expect
        XCTAssertEqual(temp, 52)
    }
}
