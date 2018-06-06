//
//  ViewController.swift
//  TestSpeech
//
//  Created by Sean on 6/6/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import UIKit
import TLSphinx

class ViewController: UIViewController {
    
    var decoder: TLSphinx.Decoder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        decodeSpeech()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getModelPath() -> NSString? {
        //        return Bundle(for: HomeViewController.self).path(forResource: "en-us", ofType: nil) as NSString?
        return Bundle.main.path(forResource: "en-us", ofType: nil)! as NSString
    }
    
    func tlSphinxTest() {
        guard let modelPath = getModelPath() else {
            print("Model Voice Error")
            return
        }
        
        let hmm = modelPath.appendingPathComponent("en-us")
        let lm = modelPath.appendingPathComponent("en-us.lm.dmp")
        let dict = modelPath.appendingPathComponent("cmudict-en-us.dict")
        
        guard let config = Config(args: ("-hmm", hmm), ("-lm", lm), ("-dict", dict)) else {
            print("Error in the Config")
            return
        }
        
        config.showDebugInfo = true
        
        guard let decoder = Decoder(config:config) else {
            print("Error in the Decoder")
            return
        }
        
        
        try! decoder.startDecodingSpeech({ (hypothesis) in
            print("Utterance: \(String(describing: hypothesis?.text))")
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: DispatchTime.now().rawValue) + Double(Int64(15.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            decoder.stopDecodingSpeech()
        }
    }
    
    func decodeSpeech() {
        guard let modelPath = getModelPath() else {
            print("error")
            return
        }
        
        let hmm = modelPath.appendingPathComponent("en-us")
        let lm = modelPath.appendingPathComponent("en-us.lm.dmp")
        let dict = modelPath.appendingPathComponent("cmudict-en-us.dict")
        
        guard let config = Config(args: ("-hmm", hmm), ("-lm", lm), ("-dict", dict)) else {
            return
        }
        
        config.showDebugInfo = true
        
        //        guard let decoder = Decoder(config:config) else {
        //            return
        //        }
        
        decoder = Decoder(config:config)
        
        //        try! decoder.startDecodingSpeech({ (hypothesis) in
        //            print("Utterance: \(hypothesis?.text)")
        //        })
        
        
        try? decoder.startDecodingSpeech { (hypothesis) in
            print(hypothesis)
        }
    }

    
}

