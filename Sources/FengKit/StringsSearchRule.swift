//
//  StringsSearchRule.swift
//  Feng
//
//  Created by 蓉蓉 邓 on 17/03/2017.
//
//

import Foundation

protocol StringsSearcher {
    func search(in content: String) -> Set<String>
}

protocol RegexStringsSearcher: StringsSearcher {
    var extensions: [String] { get }
    var patterns: [String] { get }
}

extension RegexStringsSearcher {
    func search(in content: String) -> Set<String> {
        
        var result = Set<String>()
        
        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)")
                continue
            }
            
            let matches = regex.matches(in: content, options: [], range: content.fullRange)
            for checkingResult in matches {
                let range = checkingResult.rangeAt(1)
                let extracted = NSString(string: content).substring(with: range)
                result.insert(extracted.plainName(extensions: extensions))
            }
        }
        return result
    }
}

struct SwiftSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["\"(.+?)\""]
}

struct ObjCSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["@\"(.+?)\"", "\"(.+?)\""]
}

struct XibSearcher: RegexStringsSearcher {
    let extensions: [String]
    let patterns = ["image name=\"(.+?)\""]
}

struct GeneralSearcher: RegexStringsSearcher {
    let extensions: [String]
    var patterns: [String] {
        if extensions.isEmpty {
            return []
        }
        
        let joined = extensions.joined(separator: "|")
        return ["\"(.+?)\\.(\(joined))\""]
    }
}
