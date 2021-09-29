//
//  ShapedView.swift
//  moveLayerDemo
//
//  Created by Andy on 2021/9/29.
//

import UIKit

class ShapedView: UIView {
    
    var points: [CGPoint] = []
    var currentTouchPointIndex: Int? = nil
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        let linePath = UIBezierPath()
        for i in points.indices {
            let point = points[i]
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x - 7,
                                                      y: point.y - 7,
                                                      width: 14.0,
                                                      height: 14.0))
            let dotLayer = CAShapeLayer()
            dotLayer.path = dotPath.cgPath
            dotLayer.strokeColor = UIColor.cyan.cgColor
            self.layer.addSublayer(dotLayer)
            
            if (i == 0) {
                linePath.move(to: point)
            } else {
                linePath.addLine(to: point)
            }
        }
        linePath.close()
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.yellow.withAlphaComponent(0.2).cgColor
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = UIColor.yellow.cgColor
        self.layer.insertSublayer(lineLayer, at: 0)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.customInit()
    }
    
    private func customInit() {
        self.isUserInteractionEnabled = true
        points.append(CGPoint(x: (self.bounds.minX + self.bounds.midX) / 2,
                              y: (self.bounds.minY + self.bounds.midY) / 2))
        points.append(CGPoint(x: (self.bounds.midX + self.bounds.midX) / 2,
                              y: (self.bounds.minY + self.bounds.midY) / 2))
        points.append(CGPoint(x: (self.bounds.midX + self.bounds.maxX) / 2,
                              y: (self.bounds.minY + self.bounds.midY) / 2))
        points.append(CGPoint(x: (self.bounds.midX + self.bounds.maxX) / 2,
                              y: (self.bounds.midY + self.bounds.midY) / 2))
        points.append(CGPoint(x: (self.bounds.midX + self.bounds.maxX) / 2,
                              y: (self.bounds.midY + self.bounds.maxY) / 2))
        points.append(CGPoint(x: (self.bounds.midX + self.bounds.midX) / 2,
                              y: (self.bounds.midY + self.bounds.maxY) / 2))
        points.append(CGPoint(x: (self.bounds.minX + self.bounds.midX) / 2,
                              y: (self.bounds.midY + self.bounds.maxY) / 2))
        points.append(CGPoint(x: (self.bounds.minX + self.bounds.midX) / 2,
                              y: (self.bounds.midY + self.bounds.midY) / 2))
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            var pointIndex: Int? = nil
            for i in points.indices {
                let distance = points[i].distance(from: currentPoint)
                if (distance < 30) {
                    pointIndex = i
                    break;
                }
            }
            self.currentTouchPointIndex = pointIndex
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            if let index = self.currentTouchPointIndex {
                if points.count > index {
                    points[index] = currentPoint
                    self.setNeedsDisplay()
                }
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            if let index = self.currentTouchPointIndex {
                if points.count > index {
                    points[index] = currentPoint
                    self.currentTouchPointIndex = nil
                    self.setNeedsDisplay()
                }
            }
        }
    }

}

extension CGPoint {
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}
