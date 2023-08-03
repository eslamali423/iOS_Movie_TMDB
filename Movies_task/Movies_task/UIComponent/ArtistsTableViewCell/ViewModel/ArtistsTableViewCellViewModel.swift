//
//  ArtistsTableViewCellViewModel.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import Foundation

class ArtistsTableViewCellViewModel {
    
    //MARK: - Variables
    private let cellModel: ArtistModel!
    
    var name : String? {
        return cellModel.name
    }
    
    var image : URL? {
       
        return URL(string: "\(APIConstants.manger.apiURL())\(cellModel.profilePath ?? "")")
    }
    
    var description : String? {
        return cellModel.knownForDepartment
    }
    
    
    //MARK: - Initlizers
    init(cellModel: ArtistModel!) {
        self.cellModel = cellModel
    }
}
