//
//  HomeViewController.swift
//  ios_youtube
//
//  Created by Owen Ancelot on 03/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SubscriptionService.getSubscription() { err, result in
            guard err == nil else {
                DispatchQueue.main.async {
                    print(err)
                }
                return
            }
            guard let snippets = result else {
                DispatchQueue.main.async {
                    print("No result")
                }
                return
            }
            for snippet in snippets {
                DispatchQueue.main.async {
                    print("\(snippet) \n")
                }
            }
        }
    }

}
