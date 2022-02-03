//
//  Snippet.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation

// Les APIs youtube retourne toutes des Snippet sous ce format
public class Snippet: CustomStringConvertible {
    
    let id: String
    let title: String
    let desc: String
    let URLImage: URL
    let channelId: String
    let publishedAt: Date?
    
    public var description: String {
        return "\(self.id) : \(self.title) --- \(self.channelId)"
    }
    
    public init(id: String, title: String, desc: String, URLImage: URL, channelId: String, publishedAt: Date?) {
        self.id = id
        self.title = title
        self.desc = desc
        self.URLImage = URLImage
        self.channelId = channelId
        self.publishedAt = publishedAt
    }
    
}
