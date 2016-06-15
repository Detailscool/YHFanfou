//
//  Extend+UIView.swift
//  GTMobile
//
//  Created by tung on 16/1/13.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIView {
    // MARK: Frame Extensions
    private struct UIViewID {
        static var id = "gt_id"
    }
    
    private struct UIViewAction {
        static var action = "gt_action"
    }
    
    var id: String? {
        get {
            return objc_getAssociatedObject(self, &UIViewID.id) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &UIViewID.id,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    var event: String? {
        get {
            return objc_getAssociatedObject(self, &UIViewAction.action) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &UIViewAction.action,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    public func autoHeight() -> CGFloat {
        // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
        // of growing horizontally, in a flow-layout manner.
        let tempWidthConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: self.width)
        self.addConstraint(tempWidthConstraint)
        
        // Make sure the constraints have been set up for this cell, since it may have just been created from
        // scratch. Use the following lines, assuming you are setting up constraints from within the cell's
        // updateConstraints method:
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        
        // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
        // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews]
        // method of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        // Auto layout engine does its math
        var fittingSize: CGSize = CGSizeZero
        fittingSize = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        self.removeConstraint(tempWidthConstraint)
        return fittingSize.height
    }
    
    // MARK: addBorder CornerRadius
    public func addBorder (width: CGFloat,color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.CGColor
        self.layer.masksToBounds = true
    }
    
    
    public func setCornerRadius (radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // MARK: Gesture Extensions
    
    public func addTapGesture (tapNumber: NSInteger,
        target: AnyObject, action: Selector) {
            let tap = UITapGestureRecognizer (target: target, action: action)
            tap.numberOfTapsRequired = tapNumber
            self.addGestureRecognizer(tap)
    }
    
    public func addSwipeGesture (direction: UISwipeGestureRecognizerDirection,
        numberOfTouches: Int,
        target: AnyObject,
        action: Selector) {
            let swipe = UISwipeGestureRecognizer (target: target, action: action)
            swipe.direction = direction
            swipe.numberOfTouchesRequired = numberOfTouches
            self.addGestureRecognizer(swipe)
    }
    
    public func addPanGesture (target: AnyObject,
        action: Selector) {
            let pan = UIPanGestureRecognizer (target: target, action: action)
            self.addGestureRecognizer(pan)
    }
}
