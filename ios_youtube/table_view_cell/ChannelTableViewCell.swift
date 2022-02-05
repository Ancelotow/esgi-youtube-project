//
//  ChannelTableViewCell.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
                print(channel.title)
                for video in allVideo {
                    print(video)
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
