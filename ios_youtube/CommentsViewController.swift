//
//  CommentsViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 01/03/2022.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableViewComments: UITableView!
    static let commentCellID = "COMMENT_CELL_ID"
    var videoId: String!
    var comments: [Comment] = [] {
        didSet {
            self.tableViewComments.reloadData()
        }
    }
    
    static func newInstance(videoId: String) -> CommentsViewController {
        let commentViewController = CommentsViewController()
        commentViewController.videoId = videoId
        return commentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshComments()
    }
    
    func refreshComments(){
        let commentCell = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.tableViewComments.register(commentCell, forCellReuseIdentifier: CommentsViewController.commentCellID)
        self.tableViewComments.dataSource = self
        self.tableViewComments.delegate = self
        VideoService.getComments(idVideo: self.videoId) { err, result in
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsViewController.commentCellID, for: indexPath) as! CommentTableViewCell
        cell.redraw(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = self.comments[indexPath.row]
        print(comment)
    }

    @IBAction func sendComment(_ sender: Any) {
    }
    
}
