//
//  DataViewController.swift
//  Word2Vec-iOS
//
//  Created by Tom Power on 29/08/2017.
//  Copyright © 2017 OWL. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    var circle: CircleView!
    let size = 45.0 as CGFloat
    var model: Word2VecModel!
    var circleArray = [CircleView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word2VecSetup()
        // App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        circle = CircleView(frame: CGRect(x: self.view.frame.midX-size, y: self.view.frame.midY-size, width: size*2.0, height: size*2.0))
        circle.setLabelText(appDelegate.seedWord)
        circle.bringSubview(toFront: view)

        view.addSubview(circle)
        
        // Do any additional setup after loading the view.
        
        checkModel(model: model, text: appDelegate.seedWord!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        circle.removeFromSuperview()
        circle.delegate = nil
        for circle in circleArray {
            circle.delegate = nil
            circle.removeFromSuperview()
        }
        circleArray.removeAll()
        print("Did disappear called")
        
    }
    
    
    func word2VecSetup() {
            let inputURL = Bundle.main.url(forResource: "text8", withExtension: nil)
    
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            let outputURL = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("out.bin")
    
            model = Word2VecModel()
            model.trainFile = inputURL
            model.outputFile = outputURL
    //        model.train()
    }
    
    func checkModel(model: Word2VecModel, text: String) {
            let result = model.distance(text.lowercased(), numberOfClosest: 8) // Look for 10 words semantically similar to "cat".
            print(result)
        
        var counter = 0
        let centerPoint = CGPoint(x: view.frame.width/2.0 - size, y: view.frame.height/2.0 - size)
        
        for str in (result?.keys)! {
            let x = centerPoint.x + 120*sin(CGFloat(counter)*(CGFloat.pi/4))
            let y = centerPoint.y + 120.0*cos(CGFloat(counter)*(CGFloat.pi/4))


            let circle = CircleView(frame: CGRect(x: x, y: y, width: size*2, height: size*2))
            circle.setLabelText(" ")

            circle.setLabelText(str)
            circle.bringSubview(toFront: view)
            circle.delegate = self
            view.addSubview(circle)
            circleArray.append(circle)
            counter+=1
        }
    
    }
    
    func clearAndReset() {
        for circle in circleArray {
            fadeViewOut(view: circle)
            circle.removeFromSuperview()
            print("Fade?")
        }
        circleArray.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        circle.setLabelText(appDelegate.seedWord)
        
        checkModel(model: model, text: appDelegate.seedWord!)
        
        
        
    }
    
    

    func fadeViewIn(view: UIView) {
        let aniDur = 1.0
        view.alpha = 0.0
        view.isHidden = false
        
        UIView.animate(withDuration: aniDur, animations: {() -> Void in
            
            view.alpha = 1.0
            
        })
        
    }
    
    func fadeViewOut(view: UIView) {
        let aniDur = 1.0
        
        UIView.animate(withDuration: aniDur, animations: {() -> Void in
            
            view.alpha = 0.0
            
        })
        
        view.isHidden = true
        
        
    }
}

extension DataViewController: CircleViewDelegate {
    
    func circleTapped(_ sender: CircleView) {
        if let text = sender.text {
            print(text)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.seedWord = text
            clearAndReset()
        }
    }
}

