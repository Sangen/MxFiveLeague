//
//  MXCanvasModel.swift
//  MxFiveLeague
//
//  Created by KaoruKawakita on 6/16/14.
//  Copyright (c) 2014 KaoruKawakita. All rights reserved.
//

import UIKit

class MXCanvasModel: NSObject {
    
    class func upload(#image: UIImage?,
                   groupName: String,
                  charNumber: Int,
           completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!)
    {
        let url = "answer"
        let params = ["team_id"       : groupName,
                      "answer_number" : "\(charNumber)",
                      "image"         : MXCanvasModel.toBase64(image: image)]
        
        var manager = AFHTTPSessionManager(baseURL: NSURL.URLWithString(MXUserDefaults.baseURL()))

        manager.POST(url,
            parameters: params,
            success: { (task: NSURLSessionDataTask!, responseObject:AnyObject!) in
                println("response: \(responseObject)")
            },
            failure: { (task: NSURLSessionDataTask!, error: NSError!) in
                println("Error: \(error)")
            })
    }
    
    
    class func toBase64(#image: UIImage?) -> String {
        if !image {
            return ""
        }
        let pngData = UIImagePNGRepresentation(image)
        return pngData.base64Encoding()
//        return pngData.base64EncodedDataWithOptions(options: NSDataBase64EncodingOptions)
    }
}
