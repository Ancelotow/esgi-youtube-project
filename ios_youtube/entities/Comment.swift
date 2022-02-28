//
//  Comment.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 28/02/2022.
//

import Foundation

public class Comment {
    
    let id: String
    let text: String
    let author: String
    let videoId: String
    let publishedAt: Date?
    
    init(id: String, text: String, author: String, videoId: String, publishedAt: Date?) {
        self.id = id
        self.text = text
        self.author = author
        self.videoId = videoId
        self.publishedAt = publishedAt
    }
    
}
