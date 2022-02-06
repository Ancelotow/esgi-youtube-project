//
//  ImageDownloader.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 06/02/2022.
//

import Foundation
import UIKit

public class ImageDownloader {
    
    var task: URLSessionDataTask?
    
    func download(URL: URL, completion: @escaping (Error?, UIImage?) -> Void){
        self.task?.cancel()
        let task = URLSession.shared.dataTask(with: URL) { data, res, err in
            guard err == nil else {
                completion(err, nil)
                return
            }
            guard let d = data else {
                completion(NSError(domain: "com.esgi.youtube", code: 2, userInfo: [
                    NSLocalizedFailureErrorKey: "No image found"
                ]), nil)
                return
            }
            guard let img = UIImage(data: d) else {
                completion(NSError(domain: "com.esgi.youtube", code: 4, userInfo: [
                    NSLocalizedFailureErrorKey: "No image found"
                ]), nil)
                return
            }
            completion(nil, img)
        }
        self.task = task
        task.resume() // démarrer la requête
    }
    
}
