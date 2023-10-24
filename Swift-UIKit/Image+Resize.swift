//
//  Image+Resize.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/03.
//

import Foundation
import UIKit

extension UIImage {
    /// gives a new width and the UIImage will scale to fit the new width
    func scale(newWidth: CGFloat) -> UIImage {
        // return if newWidth is the same of current image
        guard self.size.width != newWidth else{ return self }
        
        // caculate scale factor (e.g 10 / 100 = 0.1)
        let scaleFactor = newWidth / self.size.width
        
        // get newHeight with scale factore
        let newHeight = self.size.height * scaleFactor
        
        // set new size using new width and height
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        // this function begin image context and will open a drawing space from the UIImage and draw in the space,
        // if scale value is 0.0, it means not scale
        // But deprecated...
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        // get the UIImage from the current draw space and named it newImage.
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        // must end image context
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    
    func newScale(newWidth: CGFloat) -> UIImage {
        // return if newWidth is the same of current image
        guard self.size.width != newWidth else{ return self }
        
        let scaleFactor = newWidth / self.size.width
        let newHeight = self.size.height * scaleFactor
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: newSize)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return renderImage
    }
    
}
