//
//  FollowListDataSource.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import Foundation
import UIKit

typealias FollowListDataSource = FollowListVC

//MARK:- UITableViewDataSource
extension FollowListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isSearchActive else {
            return self.arrayFollow.isEmpty ? 10 : self.arrayFollow.count
        }
        if let arraySearch = self.arraySearchFollow {
            return arraySearch.isEmpty ? 1 : arraySearch.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowTableViewCell = tableView.dequeueReusableCell()
        guard isSearchActive else {
            if self.arrayFollow.isEmpty {
                cell.configCell(nil)
            } else {
                let object = self.arrayFollow[indexPath.row]
                cell.configCell(object)
            }
            return cell
        }
        
        if let arraySearch = self.arraySearchFollow {
            if arraySearch.isEmpty {
                let cell = UITableViewCell()
                cell.textLabel?.text = "No Data Available"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
                cell.textLabel?.textAlignment = .center
                return cell
            } else {
                cell.configSearchCell(arraySearch[indexPath.row])
            }
        } else {
            cell.configCell(nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isSearchActive else { return }
        if (self.arraySearchFollow?.count ?? 0) - 7 == indexPath.row {
            self.pageNumer = (self.pageNumer + 1)
            self.searchUser(searchText)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isSearchActive else {
            self.pushToOtherProfileVC(arrayFollow[indexPath.row].login ?? "")
            return 
        }
        
        if let arraySearch = self.arraySearchFollow {
            self.pushToOtherProfileVC(arraySearch[indexPath.row].login ?? "")
        }
    }
}

//MARK:- UITableViewDelegate
extension FollowListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedHeight
    }
}
