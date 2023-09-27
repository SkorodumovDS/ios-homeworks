//
//  DocumentsList.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 27.09.2023.
//

import UIKit

public struct DocumentsList {
    public let text: String
}

public extension DocumentsList {
    static func make () -> [String] {
        let pathToDocs = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                             .userDomainMask, true)[0]
        
        var objCBool: ObjCBool = false
        FileManager.default.fileExists(atPath: pathToDocs, isDirectory: &objCBool)
        if objCBool.boolValue {
            do {
                var textArray : [String] = []
                let items = try FileManager.default.contentsOfDirectory(atPath: pathToDocs)
                
                for item in items {
                    textArray.append(item.lowercased())
                }
                return textArray
            } catch {
                return []
            }
        } else {
            return []
        }
    }
}
