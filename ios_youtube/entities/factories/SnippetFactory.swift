//
//  SnippetFactory.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import Foundation

public class SnippetFactory {
    
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
