//
//  TransformImage.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import Foundation
import UIKit

class ImageTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else {return nil}
        let data = image.pngData()
        return data
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let imageData = value as? Data else {return nil}
        let image = UIImage(data: imageData)
        return image
    }
    
}
