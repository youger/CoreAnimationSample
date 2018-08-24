//
//  BloomCorner.swift
//  testParticleEmitter
//
//  Created by Jingyue on 9/2/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import Foundation
import UIKit

//Nested Types
public enum CornerRect{
    
    case LeftTop
    case Top
    case RightTop
    case Left
    case LeftBottom
    case Bottom
    case RightBottom
    case Right
    
    func configureCell(emitterCell : CAEmitterCell){
        
        
    }
    struct ConfiguredCell {
        
        let content : String , color: CGColor
        struct Acceleration {
            
            let xAcceleration : CGFloat, yAcceleration : CGFloat
        }
        struct PositionRate {
            
            let originX : CGFloat, originY : CGFloat, emitX : CGFloat, emitY : CGFloat
            
        }
        let acceleration : Acceleration , position : PositionRate
    }
    
    var configure : ConfiguredCell {
        
        switch self{
            
        case .LeftTop:
            
            return ConfiguredCell(content: "dot-1", color: UIColor.red.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: -20.0, yAcceleration: -10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 0.0, originY: 0.0, emitX: 2/3.0, emitY: 2/3.0))
            
        case .Top:
            
            return ConfiguredCell(content: "dot-1-1", color: UIColor.green.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: 0.0, yAcceleration: -10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 1/3.0, originY: 0.0, emitX: 0.5, emitY: 0.5))
            
        case .RightTop:
            
            return ConfiguredCell(content: "dot-2", color: UIColor.blue.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: 10.0, yAcceleration: -10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 2/3.0, originY: 0.0, emitX: 1/3.0, emitY: 2/3.0))
            
        case .Left:
            
            return ConfiguredCell(content: "dot-2-1", color: UIColor.cyan.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: -20.0, yAcceleration: 0.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 0.0, originY: 1/3.0, emitX: 0.5, emitY: 0.5))
            
        case .LeftBottom:
            
            return ConfiguredCell(content: "dot-3", color: UIColor.yellow.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: -20.0, yAcceleration: 10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 0.0, originY: 2/3.0, emitX: 2/3.0, emitY: 1/3.0))
            
        case .Bottom:
            
            return ConfiguredCell(content: "dot-3-1", color: UIColor.magenta.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: 0.0, yAcceleration: 10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 1/3.0, originY: 2/3.0, emitX: 0.5, emitY: 0.5))
            
        case .RightBottom:
            
            return ConfiguredCell(content: "dot-4", color: UIColor.orange.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: 10.0, yAcceleration: 10.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 2/3.0, originY: 2/3.0, emitX: 1/3.0, emitY: 1/3.0))
            
        case .Right:
            
            return ConfiguredCell(content: "dot-4-1", color: UIColor.purple.cgColor, acceleration: CornerRect.ConfiguredCell.Acceleration(xAcceleration: 10.0, yAcceleration: 0.0), position: CornerRect.ConfiguredCell.PositionRate(originX: 2/3.0, originY: 1/3.0, emitX: 0.5, emitY: 0.5))
        }
    }
}
