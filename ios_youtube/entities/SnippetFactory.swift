//
//  SnippetFactory.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation

public class SnippetFactory {
    
    static func snippet(from dict: [String: Any]) -> Snippet? {
        guard   let id = dict["id"] as? String,
                let dictSnippet = dict["snippet"] as? [String: Any] else {
            return nil
        }
        // TODO: Récupérer la date si possible
        guard let title = dictSnippet["title"] as? String,
              let desc = dictSnippet["description"] as? String,
              let channelId = dictSnippet["channelId"] as? String,
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
        return Snippet(id: id, title: title, desc: desc, URLImage: imgURL, channelId: channelId, publishedAt: nil)
    }
    
    static func snippets(from array: [[String: Any]]) -> [Snippet] {
        var arrSnippet: [Snippet] = []
        for dict in array {
            if let snippet = SnippetFactory.snippet(from: dict) {
                arrSnippet.append(snippet)
            }
        }
        return arrSnippet
    }
    
    static func snippetsDictionnary(from json: Any) -> [[String: Any]]? {
        guard let dictResult = json as? [String: Any] else {
            return nil
        }
        guard let items = dictResult["items"] as? [[String: Any]] else {
            return nil
        }
        return items
    }
    
}
