//
//  Service.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation

public class Service {
    
    public static let API_URL = "https://www.googleapis.com/youtube/v3/" // URL pour les APIs de YouTube
    
    static func getURLRequest(urlStr: String, parameters: [String: String]?, method: HttpMethod) -> URLRequest? {
        guard var urlComponents = URLComponents(string: urlStr) else {
            return nil
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "key", value: Session.getSession()?.API_KEY)
        ]
        if let parameters = parameters {
            var queryItem: URLQueryItem
            for param in parameters {
                queryItem = URLQueryItem(name: param.key, value: param.value)
                urlComponents.queryItems?.append(queryItem)
            }
        }
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        guard let session = Session.getSession() else {
            return nil
        }
        let token = "Bearer " + session.getAccessToken()
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        return urlRequest;
    }
    
}
