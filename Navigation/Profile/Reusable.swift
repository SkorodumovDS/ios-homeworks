//
//  Reusable.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 20.05.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
