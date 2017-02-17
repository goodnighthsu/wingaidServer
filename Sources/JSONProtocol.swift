//
//  JSONProtocol.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/14.
//
//

import Foundation

protocol JSONProtocol {
    var json: Any{
        get
    }
}

extension Array: JSONProtocol {
    var json: Any {
        get{
            let result = self.map{ element -> Any? in
                let obj = element as AnyObject
                if let jsonObj = obj as? JSONProtocol{
                    return jsonObj.json
                }
                
                return nil
            }
            return result
        }
    }
}

extension Dictionary: JSONProtocol{
    var json: Any {
        get{
            var result = [String: Any]()
            for (key, value) in self{
                if let keyName = key as? String{
                    if let jsonValue = value as? JSONProtocol{
                        result[keyName] = jsonValue.json
                    }else{
                        result[keyName] = value
                    }
                }
            }
            return result
        }
    }
}
