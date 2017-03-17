//
//  Extensions.swift
//  Feng
//
//  Created by 蓉蓉 邓 on 17/03/2017.
//
//

import Foundation
import PathKit

extension String {
    var fullRange: NSRange {
        return NSMakeRange(0, utf16.count)
    }
    
    func plainName(extensions: [String]) -> String {
        let p = Path(self.lowercased())
        let result: String
        if let ext = p.extension, extensions.contains(ext) {
            result = p.lastComponentWithoutExtension
        } else {
            result = p.lastComponent
        }
        
        var r = result
        if r.hasSuffix("@2x") || r.hasSuffix("@3x") {
            r = String(describing: result.utf16.dropLast(3))
        }
        
        return r
    }
}
