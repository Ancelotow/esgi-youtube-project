//
//  ChannelTableViewCell.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import UIKit

class ChannelTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    static let videoCellId = "VIDEO_CELL_ID"
    var homeController: HomeViewController!
    @IBOutlet weak var collectionViewVideo: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    var videos: [Snippet] = [] {
        didSet {
            collectionViewVideo.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let videoCell = UINib(nibName: "VideoCollectionViewCell", bundle: nil)
        self.collectionViewVideo.register(videoCell, forCellWithReuseIdentifier: ChannelTableViewCell.videoCellId)
        self.collectionViewVideo.dataSource = self
        self.collectionViewVideo.delegate = self
    }

    func redraw(channel: Snippet) {
        self.labelTitle.text = channel.title
        VideoService.getVideoFromChannel(id: channel.channelId) { err, result in
            guard err == nil else {
                return
            }
            guard let allVideo = result else {
                return
            }
            DispatchQueue.main.async {
                print(allVideo.count)
                self.videos = allVideo
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let video = self.videos[indexPath.row]
        let cell = collectionViewVideo.dequeueReusableCell(withReuseIdentifier: ChannelTableViewCell.videoCellId, for: indexPath) as! VideoCollectionViewCell
        cell.redraw(video: video)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        let videoController = VideoViewController.newInstance(video: video)
        self.homeController.navigationController?.pushViewController(videoController, animated: true)
    }
    
}
