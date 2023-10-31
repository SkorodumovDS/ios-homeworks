//
//  CoreDataService.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 29.10.2023.
//

import Foundation
import CoreData
import StorageService

protocol ICoreDataService {
    func fetchModels() -> [LikedModel]
    func save(postModel: PostModel)
    func search(postModel: PostModel) -> Bool
    func remove(postModel: PostModel) ->Bool
    func remove(likedModel: LikedModel) ->Bool
    func fetchModelsWithFilter(author : String) -> [LikedModel]
}

final class CoreDataSevice {
    
    private let modelName: String
    private let objectModel: NSManagedObjectModel
    private let storageCoordinator : NSPersistentStoreCoordinator
   
    lazy var mainContext :NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = storageCoordinator
        return context
    }()
    
    lazy var backgroundContext : NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = storageCoordinator
        return context
    }()
    
    init() {
        guard let url = Bundle.main.url(forResource: "LikedModelData", withExtension: "momd")
        else {fatalError()}
        
        let path = url.pathExtension
        let name = url.lastPathComponent
        modelName = name
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {fatalError()}
        objectModel = model
        
        storageCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        let storename = name + "sqllite"
        let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let persistantStoreUrl = documentDirectoryUrl?.appendingPathComponent(storename)
        
        guard let persistantStoreUrl else {return}
        
        do {
            try storageCoordinator.addPersistentStore(type: .sqlite, at: persistantStoreUrl)
        } catch {fatalError()}
        
    }
}

extension CoreDataSevice: ICoreDataService {
    
    func fetchModelsWithFilter(author: String) -> [LikedModel] {
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author == %@", author)
        do {
            
            let likedModels: [LikedModelData] = try mainContext.fetch(fetchRequest)
            let likedModel =  likedModels.map{
                _element in
                LikedModel(navigationModel: _element)
            }
            return Array(likedModel)
        } catch {
            return []
        }
    }
    
    func fetchModels() -> [LikedModel] {
        
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        
        do {
            
            let likedModels: [LikedModelData] = try mainContext.fetch(fetchRequest)
            let likedModel =  likedModels.map{
                _element in
                LikedModel(navigationModel: _element)
            }
            return Array(likedModel)
        } catch {
            return []
        }
    }
    
    func save(postModel: StorageService.PostModel) {
        
        backgroundContext.perform {
            let navigation = LikedModelData(context: self.backgroundContext)
            navigation.author = postModel.author
            navigation.descriptionText = postModel.description
            navigation.image = postModel.image
            navigation.likes = Int32(postModel.likes)
            navigation.views = Int32(postModel.views)
            //сохраняем изменения
            do {
                try self.backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
       
    }
    
    func search(postModel: StorageService.PostModel) -> Bool {
       
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "image == %@", postModel.image)
        do {
            
            let likedModels: [LikedModelData] = try mainContext.fetch(fetchRequest)
            if likedModels.isEmpty{ return false}
            else { return true}
        } catch {
            return false
        }
    }
    
    func remove(postModel: StorageService.PostModel) -> Bool {
       
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "image == %@", postModel.image)
        do {
            
            let likedModels: [LikedModelData] = try mainContext.fetch(fetchRequest)
            likedModels.forEach{
                mainContext.delete($0)
            }
            
            //сохраняем изменения
            do {
                try mainContext.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } catch {
            return false
        }
    }
    
    func remove(likedModel: LikedModel) -> Bool {
       
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "image == %@", likedModel.image)
        do {
            
            let likedModels: [LikedModelData] = try mainContext.fetch(fetchRequest)
            likedModels.forEach{
                mainContext.delete($0)
            }
            
            //сохраняем изменения
            do {
                try mainContext.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } catch {
            return false
        }
    }
}

