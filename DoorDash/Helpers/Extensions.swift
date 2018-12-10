//
//  Extensions.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIViewController{
    func showAlert(heading:String, message:String, buttonTitle:String) {
        let alert = UIAlertController(title: heading, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
