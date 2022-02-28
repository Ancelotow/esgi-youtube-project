//
//  VideoFactory.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 05/02/2022.
//

import Foundation

public class VideoFactory {
    
    static func video(from dict: [String: Any]) -> Snippet? {
        guard  let dictSnippet = dict["snippet"] as? [String: Any] else {
            return nil
        }
        guard let dictId = dict["id"] as? [String: Any] else {
            return nil
        }
        guard let id = dictId["videoId"] as? String else {
            return nil
        }
        guard let title = dictSnippet["title"] as? String,
              let desc = dictSnippet["description"] as? String,
              let channelId = dictSnippet["channelId"] as? String,
              let thumbs = dictSnippet["thumbnails"] as? [String: Any] else {
            return nil
        }
        guard let imgDefault = thumbs["high"] as? [String: Any] else {
            return nil
        }
        guard let imgURLStr = imgDefault["url"] as? String else {
            return nil
        }
        guard let imgURL = URL(string: imgURLStr) else {
            return nil
        }
        return Snippet(id: id, title: title, desc: desc, URLImage: imgURL, channelId: channelId, publishedAt: nil, isLive: false, textDisplay: nil)
    }
    
    static func videos(from array: [[String: Any]]) -> [Snippet] {
        var arrSnippet: [Snippet] = []
        for dict in array {
            if let snippet = VideoFactory.video(from: dict) {
                arrSnippet.append(snippet)
            }
        }
        return arrSnippet
    }

    
}
