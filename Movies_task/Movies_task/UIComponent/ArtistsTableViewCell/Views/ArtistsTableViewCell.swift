//
//  ArtistsTableViewCell.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import UIKit
import SDWebImage

class ArtistsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Variables
    var cellViewModel : ArtistsTableViewCellViewModel? {
        didSet {
            configureCell()
        }
    }
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.systemGray6.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 2
        
        profileImageView.layer.cornerRadius = 30
        
    }
    
    //MARK: - Functions
    private func configureCell() {
        guard let cellViewModel else {return}
        nameLabel.text = cellViewModel.name ?? ""
        descriptionLabel.text = cellViewModel.description ?? ""
        
        if let imageUrl = cellViewModel.image {
            profileImageView.sd_setImage(with: imageUrl)
        }
    }
    
}
