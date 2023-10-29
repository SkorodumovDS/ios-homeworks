//
//  LikedModel.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 26.10.2023.
//

import Foundation
import UIKit
import CoreData
import StorageService

public struct LikedModel {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    init(navigationModel: LikedModelData) {
        self.author = navigationModel.author!
        self.description = navigationModel.descriptionText!
        self.image  = navigationModel.image!
        self.likes = Int(navigationModel.likes)
        self.views = Int(navigationModel.views)
    }
}

public extension LikedModel {
    
    static func make() -> [LikedModel] {
        return CoreDataSevice().fetchModels()
    }
    
    static func makeWithFilter(author : String) -> [LikedModel] {
        return CoreDataSevice().fetchModelsWithFilter(author: author)
    }
    
    static func save(postModel: PostModel) {
        CoreDataSevice().save(postModel: postModel)
    }
    
    static func search(postModel: PostModel) -> Bool {
        return CoreDataSevice().search(postModel: postModel)
    }
    
    static func remove(postModel: PostModel) ->Bool {
        return CoreDataSevice().remove(postModel: postModel)
    }
}
