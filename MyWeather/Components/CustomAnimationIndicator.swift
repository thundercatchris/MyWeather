//
//  CustomAnimationIndicator.swift
//  MyWeather
//
//  Created by Cerebro on 14/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        DispatchQueue.main.async {
            if self.layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                
                rotationAnimation.fromValue = 0.0
                rotationAnimation.toValue = Float.pi * 2.0
                rotationAnimation.duration = duration
                rotationAnimation.repeatCount = Float.infinity
                rotationAnimation.speed = 0.4
                
                self.layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
            }
        }
    }
    
    func stopRotating() {
        DispatchQueue.main.async {
            if self.layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
                self.layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
            }
        }
    }
}
