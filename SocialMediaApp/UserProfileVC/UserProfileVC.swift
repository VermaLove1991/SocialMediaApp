//
//  UserProfileVC.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import UIKit
import SwiftyJSON

class UserProfileVC: UIViewController {
    ///@IBOutlet
    @IBOutlet weak var tableView: UITableView!
    ///Varriable
    let estimatedHeight: CGFloat = 60.0
    var userModel: UserModel?
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
        setUpData()
        getData()
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc private func getData() {
        APIManager.sharedInstance.call(type: EndpointItem.user, params: nil) { (resultValue: UserModel?, errorValue) in
            if let result = resultValue {
                self.userModel = result
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setUpData() {
        self.tableView.register(UserProfileCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
    
    @objc func followButtonTapped(_ sender: UIButton) {
        pushToFollowVC(.follow)
    }
    
    @objc func followingButtonTapped(_ sender: UIButton) {
        pushToFollowVC(.following)
    }
    
    private func pushToFollowVC(_ type: KeyConstant.FollowListType) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FollowListVC") as! FollowListVC
        vc.followListType = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
