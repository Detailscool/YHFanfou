//
//  YHNetworkTool.swift
//  YHFanfou
//
//  Created by Detailscool on 16/5/24.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit
import AFNetworking

class YHNetworkTool: AFHTTPSessionManager {
    
    private static let networkTool : YHNetworkTool = {
        let tool = YHNetworkTool(baseURL: NSURL(string: base_url))
        tool.responseSerializer.acceptableContentTypes?.insert("application/xml")
        return tool
    }()
    
    class func sharedNetworkTool() -> YHNetworkTool {
        return networkTool
    }
    
}
