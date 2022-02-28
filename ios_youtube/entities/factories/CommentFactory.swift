//
//  CommentFactory.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 28/02/2022.
//

import Foundation

public class CommentFactory {
    
    static func comment(from dict: [String: Any]) -> Comment? {
        guard  let dictSnippet = dict["snippet"] as? [String: Any] else {
            return nil
        }
        guard let videoId = dictSnippet["videoId"] as? String else {
            return nil
        }
        guard  let dictTopComment = dictSnippet["topLevelComment"] as? [String: Any] else {
            return nil
        }
        guard let id = dictTopComment["id"] as? String,
              let dictSnippetComment = dictTopComment["snippet"] as? [String: Any] else {
            return nil
        }
        guard let text = dictSnippetComment["textOriginal"] as? String,
              let author = dictSnippetComment["authorDisplayName"] as? String  else {
            return nil
        }
        return Comment(id: id, text: text, author: author, videoId: videoId, publishedAt: nil)
    }
    
    static func comments(from array: [[String: Any]]) -> [Comment] {
        var arrComment: [Comment] = []
        for dict in array {
            if let snippet = CommentFactory.comment(from: dict) {
                arrComment.append(snippet)
            }
        }
        return arrComment
    }

    
}
