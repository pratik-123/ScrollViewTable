//
//  ImageAnimationVC.swift
//  Test
//
//  Created by Bunty on 16/03/17.
//  Copyright © 2017 Bunty. All rights reserved.
//

import UIKit

class ImageAnimationVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    let imgs : [UIImage] = [UIImage(named: "1")! , UIImage(named: "2")! , UIImage(named: "3")! , UIImage(named: "4")! , UIImage(named: "5")! , UIImage(named: "6")! , UIImage(named: "7")! , UIImage(named: "8")! , UIImage(named: "9")! , UIImage(named: "10")!]
    
    
    var index = 0
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        imageView.animationImages = imgs
//        imageView.animationDuration = 2.0
//        //imageView.animationRepeatCount = 2
//     
//        let transition : CATransition = CATransition()
//        transition.duration = 2.0
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)//kCAMediaTimingFunctionLinear)
//        
//       // transition.type = kCATransitionFromTop
//        
//        imageView.layer.add(transition, forKey: nil)
        
    }

    @IBAction func btnStart(_ sender: Any) {
        
      //  imageView.startAnimating()
        
        imageView.image = imgs[index]
        
        customAnimation()
        
    }
 
    @IBAction func btnStop(_ sender: Any) {
        
        imageView.stopAnimating()
        
    }
    
    func customAnimation()  {
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock({
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.customAnimation()
            })
            
        })
        
        
        let transition : CATransition = CATransition()
        
        transition.type = kCAAnimationRotateAutoReverse
        imageView.layer.add(transition, forKey: kCATransition)
        imageView.image = imgs[index]
        
        CATransaction.commit()
        
        index = index < imgs.count - 1 ? index + 1 : 0
    }

}
