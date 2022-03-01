//
//  VideoViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 07/02/2022.
//

import UIKit

class VideoViewController: UIViewController {

    
    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!
    @IBOutlet weak var readVideoButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
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
        if let isLive = video.isLive {
            if isLive {
                readVideoButton.setTitle("Rejoindre le DIRECT", for: .normal)
            }
        }
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
            let alert = UIAlertController(title: "LIKE", message: "Vous avez aimé la vidéo.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func dislikeVideo(_ sender: Any) {
        VideoService.rateVideo(id: video.id, rate: VideoRate.DISLIKE) { err in
            guard err == nil else {
                return;
            }
            let alert = UIAlertController(title: "DISLIKE", message: "Vous n'avez pas aimé la vidéo.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func readVideo(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/watch?v=\(video.id)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func unsubscribe(_ sender: Any) {
        SubscriptionService.unsubscribeChannel(id: self.video.channelId) { err in
            guard err == nil else {
                print(err)
                return;
            }
            // TODO: Ajouter l'appel d'un Toast
        }
    }
    
    @IBAction func gotToComment(_ sender: Any) {
        let commentController = CommentsViewController.newInstance(videoId: self.video.id)
        self.navigationController?.pushViewController(commentController, animated: true)
    }
}
