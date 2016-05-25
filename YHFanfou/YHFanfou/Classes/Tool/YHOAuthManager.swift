//
//  YHOauth.swift
//  YHFanfou
//
//  Created by 陈波文 on 16/5/25.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

class YHOAuthManager: NSObject {
    
    private static let manager : YHOAuthManager = YHOAuthManager()
    
    class func sharedManager() -> YHOAuthManager {
        return manager
    }
    
    class func requestForOAuth() {
        
        var params = [String : AnyObject]()
        params["oauth_consumer_key"] = consumer_key
        params["oauth_signature_method"] = oauth_signature_method
        params["oauth_timestamp"] = NSDate().stringFromDate()
        params["oauth_signature"] = OAuthSignature()
        params["oauth_nonce"] = "\(arc4random())"
        
        YHNetworkManager.sharedManager().request(request_token_url, params: params) { (response, error) -> Void in
            
            print("\(response)"+"---"+"\(error)")
        }
    }
    
    class func OAuthSignature() -> String {
        let httpMethod = "GET"
        let url_encode = ""
        let sorted_query_items = ""
        return httpMethod + "&" + url_encode + "&" + sorted_query_items
    }
    
}
