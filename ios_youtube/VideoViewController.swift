//
//  VideoViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 07/02/2022.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!
    @IBOutlet weak var readVideoButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageDownloader: ImageDownloader!
    var video: Snippet!
    
    static func newInstance(video: Snippet) -> VideoViewController {
        let videoViewController = VideoViewController()
        videoViewController.video = video
        videoViewController.imageDownloader = ImageDownloader()
        return videoViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.video.title
        self.descriptionLabel.text = self.video.description
        self.imageView.image = nil
        self.imageDownloader.download(URL: video.URLImage) { err, img in
            DispatchQueue.main.sync {
                self.imageView.image = img
            }
        }
    }

}
