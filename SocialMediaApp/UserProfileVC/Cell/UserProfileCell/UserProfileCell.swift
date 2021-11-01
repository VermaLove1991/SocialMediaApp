//
//  UserProfileCell.swift
//  SocialMediaApp
//
//  Created by Apple on 10/31/21.
//

import UIKit
import SkeletonView
import SDWebImage

class UserProfileCell: UITableViewCell {
    ///@IBOutlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followTitleLabel: UILabel!
    @IBOutlet weak var followingTitleLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    ///Varriable
    private let crossDisolve = 0.7
    private let skeletonColor = UIColor.lightGray.withAlphaComponent(0.5)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showSkeleton()
    }

    private func showSkeleton() {
        profileImage.isSkeletonable = true
        descriptionLabel.isSkeletonable = true
        nameLabel.isSkeletonable = true
        userNameLabel.isSkeletonable = true
        followTitleLabel.isSkeletonable = true
        followingTitleLabel.isSkeletonable = true
        followLabel.isSkeletonable = true
        followingLabel.isSkeletonable = true
        
        profileImage.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        descriptionLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        nameLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        userNameLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        followTitleLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        followingTitleLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        followLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        followingLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
    }
    
    private func hideSkeleton() {
        profileImage.hideSkeleton()
        descriptionLabel.hideSkeleton()
        nameLabel.hideSkeleton()
        userNameLabel.hideSkeleton()
        followTitleLabel.hideSkeleton()
        followingTitleLabel.hideSkeleton()
        followLabel.hideSkeleton()
        followingLabel.hideSkeleton()
    }
    
    func configCell(_ userModel: UserModel?) {
        if let userModel = userModel {
            profileImage.sd_setImage(with: URL(string: userModel.avatarURL), placeholderImage: UIImage(named: "placeholder.png"))
            descriptionLabel.text = userModel.bio
            nameLabel.text = userModel.name
            userNameLabel.text = userModel.login
            followLabel.text = "\(userModel.followers)"
            followingLabel.text = "\(userModel.following)"
            hideSkeleton()
        } else {
            showSkeleton()
        }
    }
}
