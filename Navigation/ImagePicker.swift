//
//  ImagePicker.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 27.09.2023.
//

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{
    
    var imagePickerController: UIImagePickerController?
    var competion : ((UIImage)-> ())?
    let pathToDocum = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                      .userDomainMask, true)[0])
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage)-> ())?) {
        self.competion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image  = info[.originalImage] as? UIImage {
            if let dataImage = image.jpegData(compressionQuality: 1.0) {
                do {
                    let fileURL = self.pathToDocum!.appendingPathComponent("\(image.description).png")
                    try dataImage.write(to: fileURL)
                    self.competion?(image)}
                catch {}
            }
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
