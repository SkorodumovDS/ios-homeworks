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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        
        do {
            
            let likedModels: [LikedModelData] = try context.fetch(fetchRequest)
            let likedModel =  likedModels.map{
                _element in
                LikedModel(navigationModel: _element)
            }
            return Array(likedModel)
        } catch {
            return []
        }
    }
    
    static func save(postModel: PostModel) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let navigation = LikedModelData(context: context)
        navigation.author = postModel.author
        navigation.descriptionText = postModel.description
        navigation.image = postModel.image
        navigation.likes = Int32(postModel.likes)
        navigation.views = Int32(postModel.views)
        //сохраняем изменения
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
