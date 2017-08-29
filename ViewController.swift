//
//  ViewController.swift
//  Word2Vec-iOS
//
//  Created by Tanya on 10/8/15.
//  Copyright © 2015 OWL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func setSeedText(_ sender: UITextField) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.seedWord = sender.text
        print(appDelegate.seedWord)
        performSegue(withIdentifier: "dataSegue", sender: nil)
    }
    

//    func word2Vec() {
//        let inputURL = Bundle.main.url(forResource: "text8", withExtension: nil)
//
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0]
//        let outputURL = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("out.bin")
//
//        let model = Word2VecModel()
//        model.trainFile = inputURL
//        model.outputFile = outputURL
////        model.train()
//        checkModel(model: model)
//    }
//
//    func checkModel(model: Word2VecModel) {
//        let result = model.distance("cat", numberOfClosest: 10) // Look for 10 words semantically similar to "cat".
//        print(result)
//
//    }

}

