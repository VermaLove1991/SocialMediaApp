//
//  FollowTableViewCell.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import UIKit
import SkeletonView

class FollowTableViewCell: UITableViewCell {
    ///@IBOutlet
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    ///Varriable
    private let crossDisolve = 0.7
    private let skeletonColor = UIColor.lightGray.withAlphaComponent(0.5)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        showSkeleton()
    }
    
    private func showSkeleton() {
        profileImageView.isSkeletonable = true
        descriptionLabel.isSkeletonable = true
        userNameLabel.isSkeletonable = true

        profileImageView.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        descriptionLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
        userNameLabel.showSkeleton(usingColor: skeletonColor, animated: true, delay: 0.0, transition: .crossDissolve(crossDisolve))
    }
    
    private func hideSkeleton() {
        profileImageView.hideSkeleton()
        descriptionLabel.hideSkeleton()
        userNameLabel.hideSkeleton()
    }
    
    func configCell(_ model: FollowModel?) {
        if let resultModel = model {
            profileImageView.sd_setImage(with: URL(string: resultModel.avatarURL), placeholderImage: UIImage(named: "placeholder.png"))
            userNameLabel.text = model?.login ?? ""
            descriptionLabel.text = model?.id.description ?? ""
            hideSkeleton()
        } else {
            showSkeleton()
        }
    }
    
    func configSearchCell(_ model: SearchModelItem?) {
        if let resultModel = model {
            profileImageView.sd_setImage(with: URL(string: resultModel.avatarURL), placeholderImage: UIImage(named: "placeholder.png"))
            userNameLabel.text = model?.login ?? ""
            descriptionLabel.text = model?.id.description ?? ""
            hideSkeleton()
        } else {
            showSkeleton()
        }
    }
}
