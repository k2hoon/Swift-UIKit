//
//  ImageResizer.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/24.
//

import UIKit

class ImageResizer {
    func downSample(data: Data?, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        guard let data = data else { return nil }
        
        let cfData = data as CFData
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let maxPixel = max(size.width, size.height) * scale
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ]
        
        guard let imageSource = CGImageSourceCreateWithData(cfData, imageSourceOption),
              let downSampleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) else {
            return nil
        }
        
        return UIImage(cgImage: downSampleImage)
    }
    
    func downSample(url: URL?, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let options = [kCGImageSourceShouldCache: false] as CFDictionary
        let maxPixel = max(size.width, size.height) * scale
        let downsampleOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ]
        
        guard let url = url,
              let imageSource = CGImageSourceCreateWithURL(url as NSURL, options),
              let downSampleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions as CFDictionary) else {
            return nil
        }
        
        return UIImage(cgImage: downSampleImage)
    }
}
