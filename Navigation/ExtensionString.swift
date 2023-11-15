//
//  ExtensionString.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 15.11.2023.
//

import Foundation

extension String {
    func localized() -> String {
            NSLocalizedString(self,
                              tableName: "Localizable",
                              bundle: .main,
                              value: self,
                              comment: self)
    }
}
