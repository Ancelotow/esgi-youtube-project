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
    }

    func redraw(comment: Comment) {
        self.labelComment.text = comment.text
        self.comment = comment
    }
    
}
