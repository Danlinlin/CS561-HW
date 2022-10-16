import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseUrl :String {
    case production = "https://api.openweathermap.org/data/2.5/weather"
    case mockServer = "http://localhost:8080/data/2.5/weather"
}

class WeatherServiceImpl: WeatherService {
    let url = "\(BaseUrl.production.rawValue)?q=corvallis&units=imperial&appid=a44cb62c1bc7e4bccb0c3d467d57c483"
    //let url = "\(BaseUrl.mockServer.rawValue)?q=corvallis&units=imperial&appid=a44cb62c1bc7e4bccb0c3d467d57c483"

    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

public struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
