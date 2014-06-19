//
//  MXUserDefaults.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/15/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXUserDefaults: NSObject {
    
    class func setupDefaultValues() {
        let defaultValues = [
            "groupID"        : "0",
            "baseURLHistory" : "http://127.0.0.1:3000"
        ] as NSDictionary
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.registerDefaults(defaultValues)
        userDefaults.synchronize()
    }
    
    class func groupID() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("groupID")
    }
    
    class func setGroupID(groupID: Int) {
        assert(groupID >= 0 && groupID < 3, "Out of Range")
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(groupID, forKey: "groupID")
        userDefaults.synchronize()
    }
    
    class func groupName() -> String {
        let groupNames = ["A", "B", "C"]
        return groupNames[MXUserDefaults.groupID()]
    }
    
    class func baseURLHistory() -> String[] {
        let baseURLs = NSUserDefaults.standardUserDefaults().arrayForKey("baseURLHistory") as String[]?
        println(baseURLs)
        return baseURLs?.count > 0 ? baseURLs! : String[]()
    }
    
    class func baseURL() -> String {
        let baseURLs = MXUserDefaults.baseURLHistory()
        return baseURLs.isEmpty ? "" : baseURLs[0]
    }
    
    class func addBaseURLToHistroy(url :String) {
        if url.isEmpty {
            return
        }
        var baseURLs :String[] = MXUserDefaults.baseURLHistory()
        // remove same url
        for (index, baseURL: String) in enumerate(baseURLs) {
            if baseURL == url {
                baseURLs.removeAtIndex(index)
                break
            }
        }
        // add new url in front
        baseURLs.insert(url, atIndex: 0)
        println(baseURLs)
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(baseURLs, forKey: "baseURLHistory")
        userDefaults.synchronize()
    }
    
}
