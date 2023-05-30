//
//  PostViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.05.2023.
//

import UIKit
import StorageService

class PostModelViewController: UIViewController {

    private var data: PostModel? = nil
       
       func update(model: PostModel) {
           data = model
       }
}

