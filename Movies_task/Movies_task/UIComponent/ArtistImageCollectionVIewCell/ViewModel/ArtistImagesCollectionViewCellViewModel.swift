//
//  ArtistImagesCollectionViewCellViewModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation

class ArtistImagesCollectionViewCellViewModel {
    
    let cellModel: ImageModel!
    
    var image: URL? {
        return URL(string: "\(APIConstants.manger.imageUrl())\(cellModel.file_path ?? "")")
    }
    
    init(cellModel: ImageModel!) {
        self.cellModel = cellModel
    }
    
}
