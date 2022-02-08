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
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var buttonDislike: UIButton!
    
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
    
    @IBAction func likeVideo(_ sender: Any) {
        VideoService.rateVideo(id: video.id, rate: VideoRate.LIKE) { err in
            guard err == nil else {
                return;
            }
            let refreshAlert = UIAlertController(title: "Like", message: "Vous avez aimé la vidéo", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.show(self, sender: nil)
        }
    }
    
    @IBAction func dislikeVideo(_ sender: Any) {
        VideoService.rateVideo(id: video.id, rate: VideoRate.DISLIKE) { err in
            guard err == nil else {
                return;
            }
            let refreshAlert = UIAlertController(title: "Dislike", message: "Vous n'avez pas aimé la vidéo", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.show(self, sender: nil)
        }
    }
    
}
