//
//  CommentTableViewCell.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 28/02/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelComment: UILabel!
    var comment: Comment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelComment.layer.masksToBounds = true
        self.labelComment.layer.cornerRadius = 5
    }

    func redraw(comment: Comment) {
        self.labelComment.text = comment.text
        self.comment = comment
    }
    
}
