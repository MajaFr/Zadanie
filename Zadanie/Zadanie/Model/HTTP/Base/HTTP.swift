//
//  HTTP.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

class HTTP {
    typealias Response = (Result<NetworkResponse, AppError>) -> ()
    
    private let session: URLSession
    private let jsonParser: JSONParser
    
    public init(jsonParser: JSONParser) {
        self.jsonParser = jsonParser
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        session = URLSession.init(configuration: config)
    }
    
    func makeRequestAndParse<T: Codable>(
        _ request: Request,
        completion: @escaping (Result<T, Error>) -> ()) {
        makeRequest(request) { [weak self] (response) in
            self?.parseHttpResponse(response: response, completion: completion)
        }
    }
    
    func makeRequest(_ request: Request, response: @escaping Response) {
        guard let urlRequest = buildURLRequest(from: request) else {
            response(.failure(AppError.connectionError))
            return
        }
        
        makeRequest(urlRequest, httpMethod: urlRequest.httpMethod, response: response)
    }

    private func makeRequest(_ urlRequest: URLRequest, httpMethod: String?, response: @escaping Response) {
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                guard
                    let httpURLResponse = urlResponse as? HTTPURLResponse,
                    let data = data,
                    error == nil
                else {
                    response(.failure(AppError.networkError))
                    return
                }
                
                let networkResponse = NetworkResponse(data: data, httpHeader: httpURLResponse.allHeaderFields, statusCode: httpURLResponse.statusCode)
                response(.success(networkResponse))
            }
        }

        task.resume()
    }
    
    private func buildURLRequest(from request: Request) -> URLRequest? {
        guard let requestURL = request.url else { return nil }
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = request.method.string
        
        return urlRequest
    }
    
    private func parseHttpResponse<T: Codable>(response: (Result<NetworkResponse, AppError>), completion: @escaping (Result<T, Error>) -> ()) {
        switch response {
        case let .success(result):
            guard let data = result.data, result.isSuccess else {
                completion(.failure(AppError.parsing))
                return
            }
            let result = self.jsonParser.decode(data: data, type: T.self)
            completion(result)
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
