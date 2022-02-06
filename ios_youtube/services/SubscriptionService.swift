//
//  SubscriptionService.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation

public class SubscriptionService {
    
    static func getSubscription(completion: @escaping (Error?, [Snippet]?) -> Void) -> Void {
        let parameters = [ "mine": "true", "maxResults": "5"]
        let urlStr = Service.API_URL + "subscriptions"
        guard let url = Service.getURLRequest(urlStr: urlStr, parameters: parameters, method: HttpMethod.GET) else {
            completion(NSError(domain: "com.esgi.youtube", code: 1, userInfo: [
                NSLocalizedFailureReasonErrorKey: "Invalid URL"
            ]), nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard err == nil else {
                completion(err, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.esgi.youtube", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: d, options: .allowFragments)
                print(json)
                guard let dictSnippets = SnippetFactory.snippetsDictionnary(from: json) else {
                    completion(NSError(domain: "com.esgi.album", code: 3, userInfo: [
                        NSLocalizedFailureReasonErrorKey: "Invalid snippet format"
                    ]), nil)
                    return
                }
                let snippets = ChannelFactory.channels(from: dictSnippets)
                completion(nil, snippets)
            } catch {
                completion(err, nil)
                return
            }
        }
        task.resume()
    }
    
}
