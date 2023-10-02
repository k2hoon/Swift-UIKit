//
//  String+Attribute.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/03.
//

import UIKit

extension String {
    func toAttributed() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

extension NSMutableAttributedString {
    func addAttribute(_ text: String, fontSize: CGFloat = 12, fontWeight: UIFont.Weight = .regular) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        let attribute: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: text, attributes: attribute))
        
        return self
    }
    
    func replaceAttribute(_ text: String, key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        var range = NSRange(location: 0, length: self.string.count)
        var findRange = [NSRange]()
        
        while range.location != NSNotFound {
            range = (self.string as NSString).range(of: text, options: .caseInsensitive, range: range)
            findRange.append(range)
            
            if range.location != NSNotFound {
                range = NSRange(
                    location: range.location + range.length,
                    length: self.string.count - (range.location + range.length)
                )
            }
        }
        
        findRange.forEach {
            self.addAttribute(key, value: value, range: $0)
        }
        
        return self
    }
    
    func regrexAttribute(using pattern: String, key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let length = self.string.count
            let range = NSRange(location: 0, length: length)
            
            let matches = (regex.matches(in: self.string, options: [], range: range))
            matches.forEach {
                self.addAttribute(key, value: value, range: $0.range)
            }
        } catch {
            print(error)
        }
        
        return self
    }
    
    func addAttributes(_ attributes: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: NSRange(location: 0, length: self.string.count))
        return self
    }
}
