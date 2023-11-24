//
//  Themes.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 18.11.2023.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}

// Объявляем структуру темы (тип темы и цветовая палитра)
struct Theme {
    enum ThemeType {
        case light
        case dark
        @available(iOS 13.0, *)
        case adaptive
    }
    static var current = Theme.light {
        didSet{
            let scene = UIApplication.shared.connectedScenes.first
            let mainWindow = (scene as? UIWindowScene)?.keyWindow
            
            func changeTheme(for view: UIView) {
                view.applyTheme(current)
                view.subviews.forEach{ view in
                    changeTheme(for: view)}
            }
            
            mainWindow?.subviews.forEach{view in
                changeTheme(for: view)
            }
        }
    }
    let type: ThemeType
    let colors: ColorPalette
}

struct ColorPalette {
    var textColor: UIColor
    var cellBackgroundColor : UIColor
    var backgroundColor : UIColor
    var buttonColor : UIColor
   
    static let light = ColorPalette(textColor: .black, cellBackgroundColor: .systemGray6, backgroundColor: .white, buttonColor: .blue)
    static let dark = ColorPalette(textColor: .white, cellBackgroundColor: .systemGray6, backgroundColor: .black, buttonColor: .green)
}
// Объявляем набор доступных тем
extension Theme {
    static let light = Theme(type: Theme.ThemeType.light, colors: ColorPalette.light)
    static let dark = Theme(type: Theme.ThemeType.dark, colors: ColorPalette.dark)
}

protocol Themeable{
    func applyTheme(_ theme:Theme)
}

extension UIView : Themeable {
    func applyTheme(_ theme: Theme) {
        if (self is UILabel) {
            (self as! UILabel).textColor = theme.colors.textColor
            return
        }
        if (self is UITextField) {
            (self as! UITextField).textColor = theme.colors.textColor
            (self as! UITextField).layer.borderColor = theme.colors.textColor.cgColor
            return
        }
        if (self is UITableView) {
            (self as! UITableView).backgroundColor = theme.colors.buttonColor
            (self as! UITableView).layer.borderColor = theme.colors.textColor.cgColor
            return
        }
        if (self is UITableViewCell) {
            (self as! UITableViewCell).backgroundColor = theme.colors.cellBackgroundColor
            (self as! UITableViewCell).layer.borderColor = theme.colors.textColor.cgColor
            return
        }
        if (self is UIStackView) {
            (self as! UIStackView).layer.borderColor = theme.colors.textColor.cgColor
            return
        }
        if (self is UIButton) {
            (self as! UIButton).backgroundColor = theme.colors.buttonColor
            return
        }
        backgroundColor = theme.colors.backgroundColor
    }
}
