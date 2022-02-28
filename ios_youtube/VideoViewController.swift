//
//  VideoViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 07/02/2022.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    static let commentCellID = "COMMENT_CELL_ID"
    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!
    @IBOutlet weak var readVideoButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageDownloader: ImageDownloader!
    var video: Snippet!
    var comments: [Comment] = [] {
        didSet {
            self.tableViewComments.reloadData()
        }
    }
    
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
        let commentCell = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.tableViewComments.register(commentCell, forCellReuseIdentifier: VideoViewController.commentCellID)
        self.tableViewComments.dataSource = self
        self.tableViewComments.delegate = self
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
        VideoService.getComments(idVideo: self.video.id) { err, result in
            guard err == nil else {
                return
            }
            guard let allComments = result else {
                return
            }
            print(allComments.count)
            DispatchQueue.main.async {
                self.comments = allComments
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewController.commentCellID, for: indexPath) as! CommentTableViewCell
        cell.redraw(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = self.comments[indexPath.row]
        print(comment)
    }
    
}
