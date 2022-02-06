//
//  VideoCollectionViewCell.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 06/02/2022.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewVideo: UIImageView!
    var imageDownloader: ImageDownloader!
    var video: Snippet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageDownloader = ImageDownloader()
    }
    
    func redraw(video: Snippet) {
        self.video = video
        self.imageViewVideo.image = nil // vide l'image pendant le téléchargement
        self.imageDownloader.download(URL: video.URLImage) { err, img in
            DispatchQueue.main.sync {
                self.imageViewVideo.image = img
            }
        }
    }

}
