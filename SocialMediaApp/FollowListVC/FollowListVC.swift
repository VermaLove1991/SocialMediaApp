//
//  FollowListVC.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import UIKit

class FollowListVC: UIViewController {
    ///@IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    ///Varriable
    let estimatedHeight: CGFloat = 60.0
    var followListType: KeyConstant.FollowListType = .follow
    var arrayFollow = FollowModelElement()
    var arraySearchFollow: [SearchModelItem]?
    var isSearchActive = false
    var pageNumer = 1
    var searchText = ""
    var userName = ""
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(getData),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        setUpTableView()
        getData()
        self.tableView.addSubview(self.refreshControl)
        
        if followListType == .follow {
            self.title = "Followers"
        } else {
            self.title = "Followings"
        }
    }
    
    @objc private func getData() {
        var apiType: EndpointItem!
        if userName.isEmpty {
            apiType = (followListType == .follow) ? EndpointItem.followers : EndpointItem.following
        } else {
            apiType = (followListType == .follow) ? EndpointItem.otherFollowers(username: userName) : EndpointItem.otherFollowing(username: userName)
        }
        APIManager.sharedInstance.call(type: apiType, params: nil) { (resultValue: FollowModelElement?, errorValue) in
            if let result = resultValue {
                self.arrayFollow = result
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func searchUser(_ text: String) {
        let apiValue = EndpointItem.search(q: text, order: "asc", page: pageNumer)
        
        APIManager.sharedInstance.call(type: apiValue, params: nil) { (resultValue: SearchModel?, errorValue) in
            if let result = resultValue {
                self.isSearchActive = true
                self.arraySearchFollow = result.items
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FollowTableViewCell.reuseIdentifier)
    }
    
    func pushToOtherProfileVC(_ userName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtherProfileVC") as! OtherProfileVC
        vc.userName = userName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- UISearchBarDelegate
extension FollowListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = ((searchBar.text ?? "") as NSString).replacingCharacters(in: range, with: text)
        self.pageNumer = 1
        searchText = newText
        searchUser(newText)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.isSearchActive = false
            self.pageNumer = 1
            self.tableView.reloadData()
        }
    }
}
