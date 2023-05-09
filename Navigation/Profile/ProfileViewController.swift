//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 17.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    fileprivate let data = PostModel.make()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView.init(
                frame: .zero,
                style: .plain
            )
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            return tableView
        }()
    
    private enum CellReuseID: String {
           case base = "BaseTableViewCell_ReuseID"
       }
       
    override func viewDidLoad() {
            super.viewDidLoad()
            
            setupView()
            addSubviews()
            
            // 1. Задаем размеры и позицию tableView
            setupConstraints()
            
            // 2-4.
            tuneTableView()
        }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            tableView.indexPathsForSelectedRows?.forEach{ indexPath in
                tableView.deselectRow(
                    at: indexPath,
                    animated: animated
                )
            }
        }
    
    private func setupView() {
          view.backgroundColor = .white
          navigationController?.navigationBar.prefersLargeTitles = false
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
            tableView.estimatedRowHeight = 150.0
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            
            let headerView = ProfileHeaderView()
            tableView.tableHeaderView = headerView
            tableView.tableFooterView = UIView()
            
            // 3. Указываем, с какими классами ячеек и кастомных футеров / хэдеров
            //    будет работать таблица
            tableView.register(
                PostTableViewCell.self,
                forCellReuseIdentifier: CellReuseID.base.rawValue
            )
            
            // 4. Указываем основные делегаты таблицы
            tableView.dataSource = self
            tableView.delegate = self
        }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
 
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
    
        cell.update(data[indexPath.row])
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("Did select cell at \(indexPath)")
        let nextViewController = PostModelViewController()
        
        let model = data[indexPath.row]
        nextViewController.update(model: model)
        
        navigationController?.pushViewController(
            nextViewController,
            animated: true
        )
    }
}

