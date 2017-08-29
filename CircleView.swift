//
//  CircleView.swift
//  Word2Vec-iOS
//
//  Created by Tom Power on 29/08/2017.
//  Copyright © 2017 OWL. All rights reserved.
//

import UIKit
import Spring

protocol CircleViewDelegate: class {
    func circleTapped(_ sender: CircleView)
}

class CircleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var delegate: CircleViewDelegate?
    var circleLayer: CAShapeLayer!
    var label: UILabel!
     var text: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath : UIBezierPath!
        circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 5)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)

        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = 1.0;
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        
        // Don't draw the circle initially
//        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        
        label = UILabel(frame: CGRect(x: 0.0 , y: frame.size.height/2.0 - 18.0, width: (frame.size.width), height: 36.0))
        label.textColor = UIColor.blue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 11.0)
        label.numberOfLines = 2
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        self.addGestureRecognizer(tap)
        
        self.isUserInteractionEnabled = true
  
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.circleTapped(self)
    }
    
    
    
    override func layoutSubviews()
    {
        let frame = self.layer.bounds
        circleLayer.frame = frame
        layer.addSublayer(circleLayer)
        label.bringSubview(toFront: self)
        self.addSubview(label)
        
    }
    
    func setLabelText(_ text: String?) {
        
        self.label.text = text
        self.text = text
        print(self.label.text)
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
