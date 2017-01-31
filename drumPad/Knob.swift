//
//  Knob.swift
//  drumPad
//
//  Created by Olaf Kroon on 18/01/17.
//  Student number: 10787321
//  Course: Programmeerproject
//
//  Copyright © 2017 Olaf Kroon. All rights reserved.
//
// Code based on https://www.raywenderlich.com/82058/custom-control-tutorial-ios-swift-reusable-knob

import UIKit
import UIKit.UIGestureRecognizerSubclass

/*
 Knob represents a rotary knob that can be used to set values via user interaction.
 **/
class Knob: UIControl {
    
    var startAngle: CGFloat {
        get { return knobRenderer.startAngle }
        set { knobRenderer.startAngle = newValue }
    }
    var endAngle: CGFloat {
        get { return knobRenderer.endAngle }
        set { knobRenderer.endAngle = newValue }
    }
    var lineWidth: CGFloat {
        get { return knobRenderer.lineWidth }
        set { knobRenderer.lineWidth = newValue }
    }
    var pointerLength: CGFloat {
        get { return knobRenderer.pointerLength }
        set { knobRenderer.pointerLength = newValue }
    }
    
    let knobRenderer = KnobRenderer()
    var minimumValue: Float = -1.0
    var maximumValue: Float = 1.0
    var backingValue: Float = 0.01
    var continuous = true
    var value: Float {
        get { return backingValue }
        set { setValue(value: newValue, animated: false) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSublayers()
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(handleRotation(sender:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    // handleRotations updates value according to a gesture from the user.
    func handleRotation(sender: RotationGestureRecognizer) {
        let midPointAngle = (2.0 * CGFloat(M_PI) + self.startAngle - self.endAngle) / 2.0 + self.endAngle
        var boundedAngle = sender.rotation
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
            if (sender.state == UIGestureRecognizerState.ended) || (sender.state == UIGestureRecognizerState.cancelled) {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    /*
     setValue sets calculates the angle of the knob for a given value
     and then animates it.
     **/
    func setValue(value: Float, animated: Bool) {
        if value != self.value {
            self.backingValue = min(self.maximumValue, max(self.minimumValue, value))
            let angleRange = endAngle - startAngle
            let valueRange = CGFloat(maximumValue - minimumValue)
            let angle = CGFloat(value - minimumValue) / valueRange * angleRange + startAngle
            knobRenderer.setPointerAngle(pointerAngle: angle, animated: animated)
        }
    }
    
    // RoundValue sets value to 0 if it's current value is close to it.
    func roundValue() {
        if value > -0.20 && value < 0.20 {
            value = 0
        }
        
    }

    
     required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setKnobDisplay(largeButton: Bool, minimum: Float, maximum: Float){
        if largeButton == true {
            lineWidth = 5.0
            pointerLength = 10.0
        }
        minimumValue = minimum
        maximumValue = maximum
    }
    
    // CreateSublayers sets the values for of the knobrenderer object.
    func createSublayers() {
        knobRenderer.updateBounds(bounds: bounds)
        knobRenderer.strokeColor = UIColor(red: (255/255.0), green: (67/255.0), blue: (60/255.0), alpha: 1.0)
        knobRenderer.startAngle = -CGFloat(M_PI * 11.0 / 8.0);
        knobRenderer.endAngle = CGFloat(M_PI * 3.0 / 8.0);
        knobRenderer.pointerAngle = knobRenderer.startAngle;
        knobRenderer.lineWidth = 2.0
        knobRenderer.pointerLength = 6.0
        layer.addSublayer(knobRenderer.trackLayer)
        layer.addSublayer(knobRenderer.pointerLayer)
    }
     override func tintColorDidChange() {
        knobRenderer.strokeColor = tintColor
    }
}
/*
 Knobrenderer is a class that animates a rotary knob.
 **/
class KnobRenderer {
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
    
    init() {
        trackLayer.fillColor = UIColor.clear.cgColor
        pointerLayer.fillColor = UIColor.clear.cgColor
    }
    
    // setPointerAngle sets the location of the pointer of the rotaryKnob.
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
    
    /*
     updateTrackLayerPath creates an arc between the startAngle
     and endAngle values with a radius that ensures the pointer 
     will fit within the layer, and positions it on the center of the trackLayer.
     **/
    func updateTrackLayerPath() {
        let arcCenter = CGPoint(x: trackLayer.bounds.width / 2.0, y: trackLayer.bounds.height / 2.0)
        let offset = max(pointerLength, trackLayer.lineWidth / 2.0)
        let radius = min(trackLayer.bounds.height, trackLayer.bounds.width) / 2.0 - offset;
        trackLayer.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
    }
    
    // updatePointerLayerPath creates the path for the pointer at the position where angle is equal to zero.
    func updatePointerLayerPath() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: pointerLayer.bounds.width - pointerLength - pointerLayer.lineWidth / 2.0, y: pointerLayer.bounds.height / 2.0))
        path.addLine(to: CGPoint(x: pointerLayer.bounds.width, y: pointerLayer.bounds.height / 2.0))
        pointerLayer.path = path.cgPath
    }
    
    // update both layers and their line widths of the knob.
    func update() {
        trackLayer.lineWidth = lineWidth
        pointerLayer.lineWidth = lineWidth
        updateTrackLayerPath()
        updatePointerLayerPath()
    }
    
    /* 
    updateBounds takes a bounds rectangle, resizes the layers to match
    and positions the layers in the center of the bounding rectangle.
    **/
    func updateBounds(bounds: CGRect) {
        let position = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        trackLayer.bounds = bounds
        trackLayer.position = position
        pointerLayer.bounds = bounds
        pointerLayer.position = position
        update()
    }
}

/*
 RotationgestureRecognizer is custom gesture recognizer that follows
 the rotating movement of a single touch. It is similar to a
 UIPanGestureRecognizer. Therefore, it subclasses this class.
 **/
class RotationGestureRecognizer: UIPanGestureRecognizer {
    var rotation: CGFloat = 0.0
    
    override init(target: Any?, action: Selector? ) {
        super.init(target: target, action: action)
        minimumNumberOfTouches = 1
        maximumNumberOfTouches = 1
    }
    
    // touchesBegan calls updateRotationWithTouches when a button is touched.
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent) {
        super.touchesBegan(touches , with: event)
        updateRotationWithTouches(touches: touches)
    }
    
    // touchesMoved calls updateRotationWithTouches when a button is touched.
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent) {
        super.touchesMoved(touches , with: event)
        updateRotationWithTouches(touches: touches)
    }
    /**
     updateRotationWithTouches takes the set of touches and extracts the first 
     one. It then updates the rotation property using rotationForLocation to find the angle.
     */
    func updateRotationWithTouches(touches: Set<NSObject>) {
        if let touch = touches[touches.startIndex] as? UITouch {
            self.rotation = rotationForLocation(location: touch.location(in: self.view))
        }
    }
    
    // rotationForLocation calculates an angle from a CGpoint and returns this angle.
    func rotationForLocation(location: CGPoint) -> CGFloat {
        let offset = CGPoint(x: location.x - view!.bounds.midX, y: location.y - view!.bounds.midY)
        return atan2(offset.y, offset.x)
    }
}
