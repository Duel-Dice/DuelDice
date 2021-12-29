//
//  Graph.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/08.
//

import UIKit
import SwiftUI

class Graph: UIView {
    
    var backGround: CGRect?
    var bgColor: UIColor = UIColor.systemPink
    var animation = false
    var diceAmount = 0
    
    var diceNumber : [Int] {
        willSet(newValue) {
            diceAmount = 0
            for item in newValue {
                diceAmount += item
            }
        }
    }

    override init(frame: CGRect) {
        diceNumber = Array(repeating: 0, count: DICE_FACE_COUNT)
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        diceNumber = Array(repeating: 0, count: DICE_FACE_COUNT)
        super.init(coder: aDecoder)
    }

    init(frame: CGRect, bgColor: UIColor) {
        diceNumber = Array(repeating: 0, count: DICE_FACE_COUNT)
        self.bgColor = bgColor
        super.init(frame: frame)
    }
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// MARK: - set data

extension Graph {
    
    func set(bgColor: UIColor) { self.bgColor = bgColor }
    func set(animation: Bool) { self.animation = animation }
    func set(diceNumber: [Int]) {
        self.diceNumber = diceNumber
    }
    
    func setCondition() {
        backGround = backGround ?? CGRect(x: GRAPH_CORNER_RADIUS, y: 0, width: bounds.width - GRAPH_CORNER_RADIUS * 2, height: bounds.height - GRAPH_CORNER_RADIUS)
    }
    
    func setPoint(_ index: Int, _ diceAmount: Int) -> [Double] {
        var array = Array(repeating: 0.0, count: 5)
        
        array[0] = frame.width / CGFloat(15) * CGFloat(2.5 + Double(index)) // start x
        array[3] = frame.width / CGFloat(20) // lineWidth
        array[1] = frame.height / CGFloat(20) * CGFloat(19) - array[3] * 2 // start y
        array[2] = array[1] - frame.height / CGFloat(self.diceAmount) * CGFloat(diceAmount) // end y
        array[4] = CGFloat(diceAmount) / CGFloat(self.diceAmount) * CGFloat(DICE_FACE_COUNT * 2)
        
        return array
    }
}

// MARK: - animate

extension Graph {
    
    func diceNumberAnimate() {
        
        guard animation else { return }
        
        var index = 0
        for diceAmount in diceNumber {
            animateDiceGraph(index, diceAmount)
            index += 1
        }
    }
    
    func animateDiceGraph(_ index: Int, _ diceAmount: Int) {
        let point = setPoint(index, diceAmount)
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        self.layer.addSublayer(layer)

        path.move(to: CGPoint(x: point[0], y: point[1]))
        path.addLine(to: CGPoint(x: point[0], y: point[2]))

        layer.lineCap = .round
        layer.lineWidth = point[3]
        layer.strokeColor = UIColor.systemRed.cgColor
        layer.path = path.cgPath

        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = point[4]
        animation.beginTime = CACurrentMediaTime()

//        layer.add(animation, forKey: "strokeEnd")
        layer.add(animation, forKey: animation.keyPath)
    }

}

// MARK: - draw

extension Graph {
    
    func reDraw() { self.draw(self.frame) }

    override func draw(_ rect: CGRect) {
        setCondition()
        
        super.draw(rect)
        
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: backGround!, cornerRadius: GRAPH_CORNER_RADIUS)
        layer.path = path.cgPath
        layer.fillColor = bgColor.cgColor
        self.layer.addSublayer(layer)

        diceNumberAnimate()
    }

}
