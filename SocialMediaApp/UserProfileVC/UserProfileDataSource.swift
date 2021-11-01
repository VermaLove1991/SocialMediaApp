//
//  UserProfileDataSource.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import Foundation
import UIKit

typealias UserProfileDataSource = UserProfileVC

//MARK:- UITableViewDataSource
extension UserProfileDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserProfileCell = tableView.dequeueReusableCell()
        cell.configCell(userModel)
        cell.followerButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        cell.followingButton.addTarget(self, action: #selector(followingButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
}

//MARK:- UITableViewDelegate
extension UserProfileDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedHeight
    }
}
