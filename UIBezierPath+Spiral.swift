//
//  UIBezierPath+Spiral.swift
//  Glow
//
//  Created by Muhammad Abdul Subhan on 14/07/2018.
//  Copyright © 2018 subhan. All rights reserved.
//
//  Generates a UIBezierPath approximation of an arithmetic spiral
//  Swift version of https://github.com/ZevEisenberg/ZESpiral
//

import Foundation
import UIKit

extension UIBezierPath {
    
    // Checking if the lines intersect
    static private func lineIntersection(m1: CGFloat, m2: CGFloat) -> Bool {
        return m1 != m2
    }
    
    // Returns the spiral path
    static func getSpiralPath(center: CGPoint,
                              startRadius: CGFloat,
                              spacePerLoop: CGFloat,
                              startTheta: CGFloat,
                              endTheta: CGFloat,
                              thetaStep: CGFloat) -> UIBezierPath {
        
        let a = startRadius     // Start distnace from center
        let b = spacePerLoop    // Space between each loop
        
        let path = UIBezierPath()
        
        var oldTheta = startTheta
        var newTheta = startTheta
        
        var oldR = a + b * oldTheta
        var newR = a + b * newTheta

        var oldPoint = CGPoint.zero
        var newPoint = CGPoint.zero
        
        var oldSlope = CGFloat.greatestFiniteMagnitude
        var newSlope = CGFloat.greatestFiniteMagnitude
        

        newPoint.x = center.x + oldR * cos(oldTheta)
        newPoint.y = center.y + oldR * sin(oldTheta)
        
        path.move(to: newPoint)     // Moving to initial point

        var firstSlope = true
        
        while oldTheta < endTheta - thetaStep {
            oldTheta = newTheta
            newTheta += thetaStep

            oldR = newR
            newR = a + b * newTheta
            
            oldPoint.x = newPoint.x
            oldPoint.y = newPoint.y
            newPoint.x = center.x + newR * cos(newTheta)
            newPoint.y = center.y + newR * sin(newTheta)
            
            // Slope calculation with the formula:
            // (b * sinΘ + (a + bΘ) * cosΘ) / (b * cosΘ - (a + bΘ) * sinΘ)

            let aPlusBTheta = a + b * newTheta

            if firstSlope {
                oldSlope = ((b * sin(oldTheta) + aPlusBTheta * cos(oldTheta)) /
                    (b * cos(oldTheta) - aPlusBTheta * sin(oldTheta)))
                firstSlope = false
            } else {
                oldSlope = newSlope
            }

            newSlope = (b * sin(newTheta) + aPlusBTheta * cos(newTheta)) / (b * cos(newTheta) - aPlusBTheta * sin(newTheta))
            
            var controlPoint = CGPoint.zero
            
            let oldIntercept = -(oldSlope * oldR * cos(oldTheta) - oldR * sin(oldTheta))
            let newIntercept = -(newSlope * newR * cos(newTheta) - newR * sin(newTheta))
            
            let result = lineIntersection(m1: oldSlope, m2: newSlope)
            
            if result {
                let outX = (newIntercept - oldIntercept) / (oldSlope - newSlope)
                let outY = oldSlope * outX + oldIntercept
                
                controlPoint.x = outX
                controlPoint.y = outY
                
            } else {
                print("These lines should never be parallel")
            }
            
            // Offset the control point by the center offset.
            controlPoint.x += center.x
            controlPoint.y += center.y
            
            path.addQuadCurve(to: newPoint, controlPoint: controlPoint)
        }
        
        return path
    }
}
