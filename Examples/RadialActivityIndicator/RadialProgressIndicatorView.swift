//
//  RadialProgressIndicatorView.swift
//  RadialActivityIndicator
//
//  Created by Vladimir Milichenko on 2/1/16.
//  Copyright © 2016 Vladimir Milichenko. All rights reserved.
//

import UIKit

public class RadialProgressIndicatorView: UIView {
    static let sharedInstance = RadialProgressIndicatorView()
    
    private let progressSize = 76.0
    private let circleLineWidth = 7.6
    
    private var containerView: UIView?
    private var blurEffectView: UIVisualEffectView?
    private var progressView: UIView!
    private var circleLayer: CAShapeLayer!
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Private methods
    
    private func initialize() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name:UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Other methods
    class func showInView(view: UIView) {
        self.showInView(view, withBlur: false, blurStyle: .ExtraLight, startColor: UIColor.whiteColor(), endColor: UIColor.blackColor(), isIndefinitely: true)
    }
    
    class func showInView(
        view: UIView,
        withBlur: Bool = true,
        blurStyle: UIBlurEffectStyle = .ExtraLight,
        startColor: UIColor = UIColor.whiteColor(),
        endColor: UIColor = UIColor.blackColor(),
        isIndefinitely: Bool = true)
    {
        self.sharedInstance.containerView = view
        self.sharedInstance.frame = (self.sharedInstance.containerView?.frame)!
        self.sharedInstance.containerView?.addSubview(self.sharedInstance)
        
        let progressViewFrame = CGRect(x: self.sharedInstance.frame.size.width / 2.0 - CGFloat(self.sharedInstance.progressSize / 2.0),
            y: self.sharedInstance.frame.size.height / 2.0 - CGFloat(self.sharedInstance.progressSize / 2.0),
            width: CGFloat(self.sharedInstance.progressSize),
            height: CGFloat(self.sharedInstance.progressSize))
        
        self.sharedInstance.progressView = UIView()
        self.sharedInstance.progressView.frame = progressViewFrame
        self.sharedInstance.addSubview(self.sharedInstance.progressView)
        
        let gradientQuadrantWidth = self.sharedInstance.progressView.bounds.size.width / 2.0
        let gradientQuadrantHeight = self.sharedInstance.progressView.bounds.size.height / 2.0
        
        var startRed: CGFloat = 0.0
        var startGreen: CGFloat = 0.0
        var startBlue: CGFloat = 0.0
        var startAlpha: CGFloat = 0.0
        
        startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        
        var endRed: CGFloat = 0.0
        var endGreen: CGFloat = 0.0
        var endBlue: CGFloat = 0.0
        var endAlpha: CGFloat = 0.0
        
        endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let diffRed = endRed - startRed
        let diffGreen = endGreen - startGreen
        let diffBlue = endBlue - startBlue
        let diffAlpha = endAlpha - startAlpha
        
        let firstStopColor = UIColor(
            red: startRed + (diffRed / 4.0),
            green: startGreen + (diffGreen / 4.0),
            blue: startBlue + (diffBlue / 4.0),
            alpha: startAlpha + (diffAlpha / 4.0)
        )
        
        let topRightGradientLayer = CAGradientLayer()
        topRightGradientLayer.colors = [startColor.CGColor, firstStopColor.CGColor]
        topRightGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        topRightGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        topRightGradientLayer.frame = CGRect(
            x: gradientQuadrantWidth,
            y: 0.0,
            width: gradientQuadrantWidth,
            height:gradientQuadrantHeight
        )
        
        self.sharedInstance.progressView.layer.addSublayer(topRightGradientLayer)
        
        let secondStopColor = UIColor(
            red: startRed + (diffRed / 3.0),
            green: startGreen + (diffGreen / 3.0),
            blue: startBlue + (diffBlue / 3.0),
            alpha: startAlpha + (diffAlpha / 3.0)
        )
        
        let bottomRightGradientLayer = CAGradientLayer()
        bottomRightGradientLayer.colors = [firstStopColor.CGColor, secondStopColor.CGColor]
        bottomRightGradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        bottomRightGradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        bottomRightGradientLayer.frame = CGRect(
            x: gradientQuadrantWidth,
            y: gradientQuadrantHeight,
            width: gradientQuadrantWidth,
            height:gradientQuadrantHeight
        )
        
        self.sharedInstance.progressView.layer.addSublayer(bottomRightGradientLayer)
        
        let thirdStopColor = UIColor(
            red: startRed + (diffRed / 2.0),
            green: startGreen + (diffGreen / 2.0),
            blue: startBlue + (diffBlue / 2.0),
            alpha: startAlpha + (diffAlpha / 2.0)
        )
        
        let bottomLeftGradientLayer = CAGradientLayer()
        bottomLeftGradientLayer.colors = [secondStopColor.CGColor, thirdStopColor.CGColor]
        bottomLeftGradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        bottomLeftGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        bottomLeftGradientLayer.frame = CGRect(
            x: 0.0,
            y: gradientQuadrantHeight,
            width: gradientQuadrantWidth,
            height:gradientQuadrantHeight
        )
        
        self.sharedInstance.progressView.layer.addSublayer(bottomLeftGradientLayer)
        
        let topLeftGradientLayer = CAGradientLayer()
        topLeftGradientLayer.colors = [thirdStopColor.CGColor, endColor.CGColor]
        topLeftGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        topLeftGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        topLeftGradientLayer.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: gradientQuadrantWidth,
            height:gradientQuadrantHeight
        )
        
        self.sharedInstance.progressView.layer.addSublayer(topLeftGradientLayer)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: self.sharedInstance.progressView.bounds.size.width / 2.0, y: self.sharedInstance.progressView.bounds.size.height / 2.0),
            radius: CGFloat(self.sharedInstance.progressSize / 2.0 - self.sharedInstance.circleLineWidth / 2.0),
            startAngle: CGFloat(-M_PI_2),
            endAngle: CGFloat(M_PI * 1.5),
            clockwise: true
        )
        
        self.sharedInstance.circleLayer = CAShapeLayer()
        self.sharedInstance.circleLayer.path = circlePath.CGPath
        self.sharedInstance.circleLayer.fillColor = UIColor.clearColor().CGColor
        self.sharedInstance.circleLayer.strokeColor = UIColor.whiteColor().CGColor
        self.sharedInstance.circleLayer.lineWidth = CGFloat(self.sharedInstance.circleLineWidth)
        
        self.sharedInstance.progressView.layer.mask = self.sharedInstance.circleLayer
        
        if withBlur {
            let blurEffect = UIBlurEffect(style: blurStyle)
            self.sharedInstance.blurEffectView = UIVisualEffectView(effect: blurEffect)
            self.sharedInstance.blurEffectView!.frame = self.sharedInstance.bounds
            self.sharedInstance.insertSubview(self.sharedInstance.blurEffectView!, belowSubview: self.sharedInstance.progressView)
        }
        
        if isIndefinitely {
            self.sharedInstance.progressView.rotate360Degrees()
        } else {
            self.sharedInstance.circleLayer.strokeEnd = 0.0
        }
    }
    
    class func setProgress(percents: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.25
        animation.toValue = percents
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
        self.sharedInstance.circleLayer.strokeEnd = percents
        self.sharedInstance.circleLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
    class func hide() {
        self.sharedInstance.blurEffectView?.removeFromSuperview()
        self.sharedInstance.progressView.removeFromSuperview()
        
        self.sharedInstance.removeFromSuperview()
    }
    
    // MARK: - NSNotificationCenter
    
    func orientationChanged(notification: NSNotification) {
        if let containerView = self.containerView {
            self.frame = containerView.frame
            self.blurEffectView?.frame = self.frame
            self.progressView.center = self.center
        }
    }
}

// MARK: - UIView extension

extension UIView {
    func rotate360Degrees(duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, delay: 0, options: .CurveLinear, animations: { [unowned self] in
                self.transform = CGAffineTransformRotate(self.transform, CGFloat(M_PI))
            }, completion: { [unowned self] finished in
                if finished {
                    self.rotate360Degrees(duration)
                }
            }
        )
    }
}

