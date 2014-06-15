//
//  MXUserDefaults.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/15/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXUserDefaults: NSObject {
    
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
}
