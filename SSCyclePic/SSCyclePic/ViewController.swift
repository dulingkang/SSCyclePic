//
//  ViewController.swift
//  SSCyclePic
//
//  Created by dulingkang on 15/12/31.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        let image = UIImage(named: "pic1")
        let imageView = UIImageView.init(frame: CGRectMake(100, 200, (image?.size.width)!, (image?.size.height)!))
        imageView.backgroundColor = UIColor.clearColor()
        imageView.image = image
        imageView.layer.cornerRadius = (image?.size.width)!/2
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        let newImage = ImageHelper.createCycleImage(image!)
        SSFileManager.saveImage(newImage, name: "01")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

