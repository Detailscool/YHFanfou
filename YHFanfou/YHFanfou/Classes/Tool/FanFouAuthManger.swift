//
//  FanfouAuthManger.swift
//  GTMobile
//
//  Created by tung on 16/2/22.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit
import OAuthSwift

class FanFouAuthManger: UIView,UIWebViewDelegate {
    
    var gCredential: OAuthSwiftCredential?
    
    var gOauthswift :OAuth1Swift?
    
    var gToken : String = ""
    
    var gViewWebViewContent = UIWebView()
    
    class func isFanFouAuthed() -> Bool{
        let flag = NSUserDefaults.standardUserDefaults().objectForKey("oauth_token")
        if  String(flag).hasPrefix("false")||(flag==nil) {
            
            for view in  (KAppDelegate.window?.subviews)!{
                if ((view.id?.has("auth")) == true){
                   return false
                }
            }
            
           let auth = FanFouAuthManger()
           auth.oAuthFanfou()
           auth.id = "auth"
           auth.backgroundColor = UIColor.whiteColor()
           auth.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight)
           KAppDelegate.window!.addSubview(auth) 
           return false
        }
        return true;
    }
    
    class func getFanFouHeader (urlString:String,method: OAuthSwiftHTTPRequest.Method)-> [String:String]{
        
        if FanFouAuthManger.isFanFouAuthed()==false {return ["":""]}
        
        let url = NSURL(string: urlString)
        
        let credential = OAuthSwiftCredential(consumer_key: KFFConsumerKey, consumer_secret: KFFConsumerSecret)
        
        var requestHeaders = [String:String]()
        var signatureUrl = url
        
        // Check if body must be hashed (oauth1)
        let body: NSData? = nil
        
        var queryStringParameters = Dictionary<String, AnyObject>()
        let urlComponents = NSURLComponents(URL: url!, resolvingAgainstBaseURL: false )
        if let queryItems = urlComponents?.queryItems {
            for queryItem in queryItems {
                let value = queryItem.value?.safeStringByRemovingPercentEncoding ?? ""
                queryStringParameters.updateValue(value, forKey: queryItem.name)
            }
        }
        
        // According to the OAuth1.0a spec, the url used for signing is ONLY scheme, path, and query
        if(queryStringParameters.count>0)
        {
            urlComponents?.query = nil
            // This is safe to unwrap because these just came from an NSURL
            signatureUrl = urlComponents?.URL ?? url
        }
        let oauth_token = NSUserDefaults.standardUserDefaults().objectForKey("oauth_token")
        let oauth_token_secret = NSUserDefaults.standardUserDefaults().objectForKey("oauth_token_secret")
        
        credential.oauth_token = String(oauth_token as! String)
        credential.oauth_token_secret = String(oauth_token_secret as! String)
        requestHeaders += credential.makeHeaders(signatureUrl!, method: method, parameters: queryStringParameters, body: body)
        return requestHeaders
    }
    
    class func getFanFouHeader (urlString:String,parameters:[String : AnyObject]?)-> [String:String]{
        
        if FanFouAuthManger.isFanFouAuthed()==false {return ["":""]}
        
        let url = NSURL(string: urlString)
        
        let credential = OAuthSwiftCredential(consumer_key: KFFConsumerKey, consumer_secret: KFFConsumerSecret)
        
        var requestHeaders = [String:String]()
        var signatureUrl = url
        
        // Check if body must be hashed (oauth1)
        let body: NSData? = nil
        
        var queryStringParameters = Dictionary<String, AnyObject>()
        let urlComponents = NSURLComponents(URL: url!, resolvingAgainstBaseURL: false )
        if let queryItems = urlComponents?.queryItems {
            for queryItem in queryItems {
                let value = queryItem.value?.safeStringByRemovingPercentEncoding ?? ""
                queryStringParameters.updateValue(value, forKey: queryItem.name)
            }
        }
        
        if let lparameters = parameters{
            for item in lparameters.keys{
               queryStringParameters.updateValue(lparameters[item]!, forKey: item)
            }
        }
        
        // According to the OAuth1.0a spec, the url used for signing is ONLY scheme, path, and query
        if(queryStringParameters.count>0)
        {
            urlComponents?.query = nil
            // This is safe to unwrap because these just came from an NSURL
            signatureUrl = urlComponents?.URL ?? url
        }
        
        
        
        let oauth_token = NSUserDefaults.standardUserDefaults().objectForKey("oauth_token")
        let oauth_token_secret = NSUserDefaults.standardUserDefaults().objectForKey("oauth_token_secret")
        
        credential.oauth_token = String(oauth_token as! String)
        credential.oauth_token_secret = String(oauth_token_secret as! String)
        requestHeaders += credential.makeHeaders(signatureUrl!, method: .GET, parameters: queryStringParameters, body: body)
        return requestHeaders
    }


    func  oAuthFanfou(){
        self.gCredential = OAuthSwiftCredential(consumer_key: KFFConsumerKey, consumer_secret: KFFConsumerSecret)
        
        gOauthswift = OAuth1Swift(
            consumerKey:    KFFConsumerKey,
            consumerSecret: KFFConsumerSecret,
            requestTokenUrl: KFFRequestTokenURL,
            authorizeUrl:KFFAuthorizeURL,
            accessTokenUrl:KFFAccessTokenURL
        )
        
        weak var lWeakSelf = self
        gOauthswift!.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/gesantung")!,
            success: {
                credential, response, parameters in
                lWeakSelf?.initOauthWebView(credential.oauth_token)
                
            }, failure: { error in
                print(error.localizedDescription)
        })
    }
    
    func  AccessTokenOAuthFanfou(){
        gOauthswift!.postOAuthAccessTokenWithRequestToken( {
            credential, response, parameters in
                 NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token, forKey: "oauth_token")
                 NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token_secret, forKey: "oauth_token_secret")
                 NSUserDefaults.standardUserDefaults().setObject("true", forKey: "oauth_token_flag")
            }, failure: { error in
                print(error.localizedDescription)
        })
    }
    
    func initOauthWebView(token:String){
        let url = KURLAppAuthorize + token
        
        gViewWebViewContent.frame = CGRectMake(0, 20, KScreenWidth, KScreenHeight-20)
        gViewWebViewContent.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        gViewWebViewContent.delegate=self
        addSubview(gViewWebViewContent)
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        if request.URL!.absoluteString.hasPrefix("http://gesantung") {
            self.AccessTokenOAuthFanfou()
            gViewWebViewContent.removeFromSuperview()
            removeFromSuperview()
            return false
        }
        
        return true
    }

}
