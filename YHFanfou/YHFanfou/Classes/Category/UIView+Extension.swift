//
//  UIView+Extention.swift
//
//  Created by Detailscool on 16/3/19.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

import UIKit

extension UIView {
    
    var x : CGFloat {
        get{
            return frame.origin.x
        }
        
        set {
            var viewFrame = frame
            viewFrame.origin.x = newValue
            frame = viewFrame
        }
    }
    
    var y : CGFloat {
        get{
            return frame.origin.y
        }
        
        set {
            var viewFrame = frame
            viewFrame.origin.y = newValue
            frame = viewFrame
        }
    }
    
    var width : CGFloat {
        
        get{
            return frame.width
        }
        
        set {
            var viewFrame = frame
            viewFrame.size.width = newValue
            frame = viewFrame
        }
    }
    
    var height : CGFloat {
        get{
            return frame.height
        }
        
        set {
            var viewFrame = frame
            viewFrame.size.height = newValue
            frame = viewFrame
        }
    }
    
    var centerX : CGFloat {
        get{
            return center.x
        }
        
        set {
            var viewCenter = center
            viewCenter.x = newValue
            center = viewCenter
        }
    }
    
    var centerY : CGFloat {
        get{
            return center.y
        }
        
        set {
            var viewCenter = center
            viewCenter.y = newValue
            center = viewCenter
        }
    }
 
    class func viewFromXib() -> AnyObject {
        return NSBundle.mainBundle().loadNibNamed(NSStringFromClass(self).componentsSeparatedByString(".").last, owner: nil, options: nil).last!
    }
    
}