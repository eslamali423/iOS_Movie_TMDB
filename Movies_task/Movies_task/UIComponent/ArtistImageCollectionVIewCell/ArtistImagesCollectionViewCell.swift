//
//  ArtistImagesCollectionViewCell.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import UIKit
import SDWebImage

class ArtistImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    //MARK: - Variables
    var cellViewModel : ArtistImagesCollectionViewCellViewModel? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = 10
    }

    
    private func configureCell() {
        guard let cellViewModel else {return}
        
        if let imageUrl = cellViewModel.image {
            itemImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            itemImageView.sd_setImage(with: imageUrl)
        }
    }
}
