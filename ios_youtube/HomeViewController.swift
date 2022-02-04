//
//  HomeViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let channelCellID = "CHANNEL_CELL_ID"
    @IBOutlet weak var tableChannel: UITableView!
    var channels: [Snippet] = [] {
        didSet {
            self.tableChannel.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let channelCell = UINib(nibName: "ChannelTableViewCell", bundle: nil)
        self.tableChannel.register(channelCell, forCellReuseIdentifier: HomeViewController.channelCellID)
        self.tableChannel.dataSource = self
        self.tableChannel.delegate = self
        SubscriptionService.getSubscription() { err, result in
            guard err == nil else {
                return
            }
            guard let allChannels = result else {
                return
            }
            DispatchQueue.main.async {
                self.channels = allChannels
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let channel = self.channels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.channelCellID, for: indexPath) as! ChannelTableViewCell
        cell.redraw(channel: channel)
        return cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = self.channels[indexPath.row]
        print(channel)
    }

}
