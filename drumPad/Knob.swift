//
//  Knob.swift
//  drumPad
//
//  Created by Olaf Kroon on 18/01/17.
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//


//A rotary knob based on code from https://www.raywenderlich.com/82058/custom-control-tutorial-ios-swift-reusable-knob

import UIKit
import UIKit.UIGestureRecognizerSubclass

public class Knob: UIControl {
    
    public var startAngle: CGFloat {
        get { return knobRenderer.startAngle }
        set { knobRenderer.startAngle = newValue }
    }
    public var endAngle: CGFloat {
        get { return knobRenderer.endAngle }
        set { knobRenderer.endAngle = newValue }
    }
    public var lineWidth: CGFloat {
        get { return knobRenderer.lineWidth }
        set { knobRenderer.lineWidth = newValue }
    }
    public var pointerLength: CGFloat {
        get { return knobRenderer.pointerLength }
        set { knobRenderer.pointerLength = newValue }
    }
    
    private let knobRenderer = KnobRenderer()
    
    private var backingValue: Float = 0.01
    
    public var value: Float {
        get { return backingValue }
        set { setValue(value: newValue, animated: false) }
    }
    
    public func setValue(value: Float, animated: Bool) {
        if value != self.value {
            self.backingValue = min(self.maximumValue, max(self.minimumValue, value))
            let angleRange = endAngle - startAngle
            let valueRange = CGFloat(maximumValue - minimumValue)
            let angle = CGFloat(value - minimumValue) / valueRange * angleRange + startAngle
            knobRenderer.setPointerAngle(pointerAngle: angle, animated: animated)
        }
    }
    
    public var minimumValue: Float = -1.0
    public var maximumValue: Float = 1.0
    public var continuous = true
    public override init(frame: CGRect) {
        super.init(frame: frame)

        
        createSublayers()
        let gr = RotationGestureRecognizer(target: self, action: #selector(handleRotation(sender:)))
        self.addGestureRecognizer(gr)
    }
    
    func roundValue() {
        
        if value > -0.20 && value < 0.20 {
            value = 0
        }
    }
    
    func handleRotation(sender: AnyObject) {
        let gr = sender as! RotationGestureRecognizer
        let midPointAngle = (2.0 * CGFloat(M_PI) + self.startAngle - self.endAngle) / 2.0 + self.endAngle
        var boundedAngle = gr.rotation
   
        if boundedAngle > midPointAngle {
            boundedAngle -= 2.0 * CGFloat(M_PI)
        } else if boundedAngle < (midPointAngle - 2.0 * CGFloat(M_PI)) {
            boundedAngle += 2 * CGFloat(M_PI)
        }
        boundedAngle = min(self.endAngle, max(self.startAngle, boundedAngle))
        let angleRange = endAngle - startAngle
        let valueRange = maximumValue - minimumValue
        let valueForAngle = Float(boundedAngle - startAngle) / Float(angleRange) * valueRange + minimumValue
        self.value = valueForAngle
        if continuous {
            sendActions(for: .valueChanged)
        } else {
            if (gr.state == UIGestureRecognizerState.ended) || (gr.state == UIGestureRecognizerState.cancelled) {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createSublayers() {
        knobRenderer.update(bounds: bounds)
        knobRenderer.strokeColor = UIColor(red: (255/255.0), green: (67/255.0), blue: (60/255.0), alpha: 1.0)
        knobRenderer.startAngle = -CGFloat(M_PI * 11.0 / 8.0);
        knobRenderer.endAngle = CGFloat(M_PI * 3.0 / 8.0);
        knobRenderer.pointerAngle = knobRenderer.startAngle;
        knobRenderer.lineWidth = 2.0
        knobRenderer.pointerLength = 6.0
        
        layer.addSublayer(knobRenderer.trackLayer)
        layer.addSublayer(knobRenderer.pointerLayer)
    }
    
    public override func tintColorDidChange() {
        knobRenderer.strokeColor = tintColor
    }
}

private class KnobRenderer {
    var strokeColor: UIColor {
        get {
            return UIColor(cgColor: trackLayer.strokeColor!)
        }
        
        set(strokeColor) {
            trackLayer.strokeColor = strokeColor.cgColor
            pointerLayer.strokeColor = strokeColor.cgColor
        }
    }
    var lineWidth: CGFloat = 1.0 {
        didSet { update() }
    }
    
    var startAngle: CGFloat = 0.0 {
        didSet { update() }
    }
    
    var endAngle: CGFloat = 0.0 {
        didSet { update() }
    }
    
    var pointerLength: CGFloat = 0.0 {
        didSet { update() }
    }
    
    let trackLayer = CAShapeLayer()
    let pointerLayer = CAShapeLayer()
    var backingPointerAngle: CGFloat = 0.0
    var pointerAngle: CGFloat {
        get { return backingPointerAngle }
        set { setPointerAngle(pointerAngle: newValue, animated: false) }
    }
    
    func setPointerAngle(pointerAngle: CGFloat, animated: Bool) {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pointerLayer.transform = CATransform3DMakeRotation(pointerAngle, 0.0, 0.0, 0.1)
        
        if animated {
            let midAngle = (max(pointerAngle, self.pointerAngle) - min(pointerAngle, self.pointerAngle) ) / 2.0 + min(pointerAngle, self.pointerAngle)
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.25
            animation.values = [self.pointerAngle, midAngle, pointerAngle]
            animation.keyTimes = [0.0, 0.5, 1.0]
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pointerLayer.add(animation, forKey: nil)
        }
        
        CATransaction.commit()
        
        self.backingPointerAngle = pointerAngle
    }
    
    init() {
        trackLayer.fillColor = UIColor.clear.cgColor
        pointerLayer.fillColor = UIColor.clear.cgColor
    }
    
    func updateTrackLayerPath() {
        let arcCenter = CGPoint(x: trackLayer.bounds.width / 2.0, y: trackLayer.bounds.height / 2.0)
        let offset = max(pointerLength, trackLayer.lineWidth / 2.0)
        let radius = min(trackLayer.bounds.height, trackLayer.bounds.width) / 2.0 - offset;
        trackLayer.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
    }
    
    func updatePointerLayerPath() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: pointerLayer.bounds.width - pointerLength - pointerLayer.lineWidth / 2.0, y: pointerLayer.bounds.height / 2.0))
        path.addLine(to: CGPoint(x: pointerLayer.bounds.width, y: pointerLayer.bounds.height / 2.0))
        pointerLayer.path = path.cgPath
    }
    
    func update() {
        trackLayer.lineWidth = lineWidth
        pointerLayer.lineWidth = lineWidth
        updateTrackLayerPath()
        updatePointerLayerPath()
    }
    
    func update(bounds: CGRect) {
        let position = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        trackLayer.bounds = bounds
        trackLayer.position = position
        pointerLayer.bounds = bounds
        pointerLayer.position = position
        update()
    }
}

private class RotationGestureRecognizer: UIPanGestureRecognizer {
    var rotation: CGFloat = 0.0
    
    override init(target: Any?, action: Selector? ) {
        super.init(target: target, action: action)
        
        minimumNumberOfTouches = 1
        maximumNumberOfTouches = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent) {
        super.touchesBegan(touches , with: event)
        updateRotationWithTouches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent) {
        super.touchesMoved(touches , with: event)
        updateRotationWithTouches(touches: touches)
    }
    
    func updateRotationWithTouches(touches: Set<NSObject>) {
        if let touch = touches[touches.startIndex] as? UITouch {
            self.rotation = rotationForLocation(location: touch.location(in: self.view))
        }
    }
    
    func rotationForLocation(location: CGPoint) -> CGFloat {
        let offset = CGPoint(x: location.x - view!.bounds.midX, y: location.y - view!.bounds.midY)
        return atan2(offset.y, offset.x)
    }
    
}



