//
//  APIEndpoint.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/29.
//

import Foundation
import Combine

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}


class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.baseURL.absoluteString.replacing("https://", with: "")
        components.path = endpoint.path

        components.queryItems = endpoint.parameters?.keys.map { x in
            return URLQueryItem(name: x, value: endpoint.parameters?[x] as? String)
        }

//        let url = endpoint.baseURL.appendingPathComponent(components.url!)
        var request = URLRequest(url: components.url!)
        request.httpMethod = endpoint.method.rawValue

        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                print("tryMap...")
                print(response)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
