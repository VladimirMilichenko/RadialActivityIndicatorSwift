//
//  ViewController.swift
//  RadialActivityIndicator
//
//  Created by Vladimir Milichenko on 2/1/16.
//  Copyright © 2016 Vladimir Milichenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RadialProgressIndicatorView.showInView(self.view, withBlur: true, startColor: UIColor.whiteColor(), endColor: UIColor.greenColor())
        RadialProgressIndicatorView.showInView(self.view, withBlur: false, endColor: UIColor.greenColor(), isIndefinitely: false)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            RadialProgressIndicatorView.setProgress(0.1)
            RadialProgressIndicatorView.setProgress(0.2)
            RadialProgressIndicatorView.setProgress(0.3)
            RadialProgressIndicatorView.setProgress(0.4)
            RadialProgressIndicatorView.setProgress(0.5)
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                RadialProgressIndicatorView.hide()
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    RadialProgressIndicatorView.showInView(self.view, withBlur: true, blurStyle: .Dark, startColor: UIColor.whiteColor(), endColor: UIColor.greenColor())
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                        RadialProgressIndicatorView.hide()
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                            RadialProgressIndicatorView.showInView(self.view, withBlur: true, startColor: UIColor.whiteColor(), endColor: UIColor.greenColor())
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                RadialProgressIndicatorView.hide()
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                    RadialProgressIndicatorView.showInView(self.view, withBlur: true, blurStyle: .Light, startColor: UIColor.whiteColor(), endColor: UIColor.greenColor())
                                    
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                        RadialProgressIndicatorView.hide()
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                            RadialProgressIndicatorView.showInView(self.view, withBlur: true, startColor: UIColor.whiteColor(), endColor: UIColor.greenColor(), isIndefinitely: false)
                                            
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                                RadialProgressIndicatorView.setProgress(0.25)
                                                
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                                    RadialProgressIndicatorView.setProgress(0.5)
                                                    
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                                        RadialProgressIndicatorView.setProgress(0.75)
                                                        
                                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                                                            RadialProgressIndicatorView.setProgress(1.0)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

