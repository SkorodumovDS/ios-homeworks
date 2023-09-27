//
//  DocumentsViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 27.09.2023.
//

import UIKit
import StorageService

class DocumentsViewController: UIViewController {
    var pathToDocum : URL?
    fileprivate var data = DocumentsList.make()
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pictureAdd = UIBarButtonItem(title: "Add picture", style: .plain, target: self, action: #selector(infoPressed(_:)))

        navigationItem.rightBarButtonItem =  pictureAdd
        addSubviews()
        pathToDocum = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                      .userDomainMask, true)[0])
        setupConstraints()
        tuneTableView()
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
            DocumentsTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )

 
        // 4. Указываем основные делегаты таблицы
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    @objc func infoPressed(_ sender: UIButton) {
          let imPick = ImagePicker()
        imPick.showImagePicker(in: self) {image in
            if let dataImage = image.jpegData(compressionQuality: 1.0) {
                do {
                    let fileURL = self.pathToDocum!.appendingPathComponent("\(image.description).png")
                    try dataImage.write(to: fileURL)
                    self.data.append(image.description)
                    self.tableView.reloadData()
        } catch {}
            }
        }
        }
}

extension DocumentsViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { if section == 1 {
        return data.count}
        else {return 1}
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? DocumentsTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
        if data.count > 0 {
            cell.update(data[indexPath.row])
        }
            return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pathToFile = data[indexPath.row]
        //delete file for path
        let isFileExists = FileManager.default.fileExists(atPath: pathToFile)
        if isFileExists {
            do {
                try FileManager.default.removeItem(atPath: pathToFile)
                data.remove(at: indexPath.row)
                tableView.reloadData()
            }catch {}
        }
    }
}

extension DocumentsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat { if section == 0 {
        return 220}
        else {return 0 }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return nil
    }
}

