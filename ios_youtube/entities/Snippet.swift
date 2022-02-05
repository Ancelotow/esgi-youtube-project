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
    let publishedAt: Date?
    let channelId: String
    
    public var description: String {
        return "\(self.id) : \(self.title)"
    }
    
    public init(id: String, title: String, desc: String, URLImage: URL, channelId: String, publishedAt: Date?) {
        self.id = id
        self.title = title
        self.desc = desc
        self.URLImage = URLImage
        self.publishedAt = publishedAt
        self.channelId = channelId
    }
    
}
