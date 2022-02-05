//
//  ChannelFactory.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 05/02/2022.
//

import Foundation

public class ChannelFactory {
    
    static func channel(from dict: [String: Any]) -> Snippet? {
        guard   let id = dict["id"] as? String,
                let dictSnippet = dict["snippet"] as? [String: Any] else {
            return nil
        }
        guard let title = dictSnippet["title"] as? String,
              let desc = dictSnippet["description"] as? String,
              let thumbs = dictSnippet["thumbnails"] as? [String: Any] else {
            return nil
        }
        guard let imgDefault = thumbs["default"] as? [String: Any] else {
            return nil
        }
        guard let imgURLStr = imgDefault["url"] as? String else {
            return nil
        }
        guard let imgURL = URL(string: imgURLStr) else {
            return nil
        }
        guard let ressource = dictSnippet["resourceId"] as? [String: Any] else {
            return nil
        }
        guard let channelId = ressource["channelId"] as? String else {
            return nil
        }
        return Snippet(id: id, title: title, desc: desc, URLImage: imgURL, channelId: channelId, publishedAt: nil)
    }
    
    static func channels(from array: [[String: Any]]) -> [Snippet] {
        var arrSnippet: [Snippet] = []
        for dict in array {
            if let snippet = ChannelFactory.channel(from: dict) {
                arrSnippet.append(snippet)
            }
        }
        return arrSnippet
    }
    
}
