//
//  ImageController.swift
//  FlapjackBeta
//
//  Created by Kevin Hartley on 6/20/16.
//  Copyright © 2016 Hartley Development. All rights reserved.
//

import UIKit

// MARK: - UIImage extension for saving and retrieving images
extension UIImage {
    
    var base64String: String? {
        guard let data = UIImageJPEGRepresentation(self, 0.8) else {
            return nil
        }
        
        return data.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
    }
    
    convenience init?(base64: String) {
        
        if let imageData = NSData(base64EncodedString: base64, options: .IgnoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
}