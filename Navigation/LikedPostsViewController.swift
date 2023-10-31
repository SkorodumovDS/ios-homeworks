//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 26.10.2023.
//
import UIKit
import CoreData

class LikedPostsViewController: UIViewController {
   
    var fetchedResultController: NSFetchedResultsController<LikedModelData>!
    fileprivate var data : [LikedModel] = []
    private var context :NSManagedObjectContext?
    var coreDataService: CoreDataSevice? = CoreDataSevice()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case photos = "PhotosTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        
        // 1. Задаем размеры и позицию tableView
        setupConstraints()
        configureFetchController()
        fetchData()
        // 2-4.
        tuneTableView()
        tuneNavigationBar()
        
    }
   
   
    override func viewWillAppear(_ animated: Bool) {
        do {
            try fetchedResultController.performFetch()
            let likedModels: [LikedModelData] = fetchedResultController.fetchedObjects ?? []
            var likeModel = likedModels.map{
                _element in
                   LikedModel(navigationModel: _element)
            }
            data = Array(likeModel)
            tableView.reloadData()
        }catch {
            print(error.localizedDescription)
        }
    }
   
    private func tuneNavigationBar() {
       
        let filter = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPressed(_:)))

        navigationItem.rightBarButtonItem =  filter
        
        let clearFilter = UIBarButtonItem(title: "Clear filter", style: .plain, target: self, action: #selector(clearFilterPressed(_:)))

        navigationItem.leftBarButtonItem =  clearFilter
        
    }
    
    private func fetchData() {
        do {
            try fetchedResultController.performFetch()
            let likedModels: [LikedModelData] = fetchedResultController.fetchedObjects ?? []
            var likeModel = likedModels.map{
                _element in
                   LikedModel(navigationModel: _element)
            }
            data = Array(likeModel)
            tableView.reloadData()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    private func configureFetchController() {
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        let sortDecriptor = NSSortDescriptor(key: "author", ascending: false)
        fetchRequest.sortDescriptors = [sortDecriptor]
        
        context = coreDataService!.mainContext
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest
            , managedObjectContext: context!
            , sectionNameKeyPath: nil
            ,cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
            let likedModels: [LikedModelData] = fetchedResultController.fetchedObjects ?? []
            var likeModel = likedModels.map{
                _element in
                   LikedModel(navigationModel: _element)
            }
            data = Array(likeModel)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func configureFetchControllerWithFilter(author:String) {
        let fetchRequest: NSFetchRequest<LikedModelData> = LikedModelData.fetchRequest()
        let sortDecriptor = NSSortDescriptor(key: "author", ascending: false)
        fetchRequest.sortDescriptors = [sortDecriptor]
        fetchRequest.predicate = NSPredicate(format: "author == %@", author)
        
        context = coreDataService!.mainContext
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest
            , managedObjectContext: context!
            , sectionNameKeyPath: nil
            ,cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
            let likedModels: [LikedModelData] = fetchedResultController.fetchedObjects ?? []
            var likeModel = likedModels.map{
                _element in
                   LikedModel(navigationModel: _element)
            }
            data = Array(likeModel)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @objc func filterPressed(_ sender: UIButton) {
        let filterController = UIAlertController(title: "Введите автора", message: nil, preferredStyle: .alert)
        
        let filterAction = UIAlertAction(title: "Применить", style: .default) {_ in
            self.configureFetchControllerWithFilter(author: filterController.textFields?.first?.text ?? "")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        filterController.addTextField()
        filterController.addAction(filterAction)
        filterController.addAction(cancelAction)
        
        present(filterController, animated: true)
        }
    
    @objc func clearFilterPressed(_ sender: UIButton) {
            self.configureFetchController()
        }
    
    private func setupView() {
        //view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
        #if DEBUG
        view.backgroundColor = .gray
        #else
        view.backgroundColor = .green
        #endif
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    private func tuneTableView() {
        // 2. Настраиваем отображение таблицы
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 150.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }

        // 3. Указываем, с какими классами ячеек и кастомных футеров / хэдеров
        //    будет работать таблица
        tableView.register(
            LikedpostViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
 
        // 4. Указываем основные делегаты таблицы
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension LikedPostsViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? LikedpostViewCell else {
                fatalError("could not dequeueReusableCell")
            }
        if data.count > 0 {
            cell.update(data[indexPath.row])
        }
            return cell}
    
}

extension LikedPostsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") {(action, view, completionHandler) in
            
            //fetchedResultController.fetchedObjects?.remove(at: indexPath.row)
            
            self.coreDataService!.remove(likedModel: self.data[indexPath.row])
           
/*            self.data = LikedModel.make()
            tableView.reloadData()
             */
            completionHandler(true)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
}

extension LikedPostsViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            guard let newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .left)
        case .delete:
            guard let indexPath else {return}
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        case .move:
            guard let indexPath , let newIndexPath else {return}
            
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.insertRows(at: [newIndexPath], with: .left)
        case .update:
            guard let indexPath else {return}
            
            tableView.reloadRows(at: [indexPath], with: .fade)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
