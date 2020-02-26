//
//  UIImageViewEx.swift
//  RepositorySurfer
//
//  Created by Jeongsik Lee on 2020/02/26.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// display the image loaded from the URL
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let theError = error {
                print(theError.localizedDescription)
                return
            }
            guard let data = data else {
                print("Empty data error")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
