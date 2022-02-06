//
//  VideoCollectionViewCell.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 06/02/2022.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func redraw(video: Snippet) {
        self.title.text = video.title
    }

}
