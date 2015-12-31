//
//  SSFileManager.swift
//  RealmDemo
//
//  Created by dulingkang on 15/12/29.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit


struct SSFileManager {
    
    static func createFolderInDocument(name: String) {
        let fileManager = NSFileManager.defaultManager()
        let dir: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let folder = dir.stringByAppendingPathComponent(name)
        if !fileManager.fileExistsAtPath(folder){
            do {
                try fileManager.createDirectoryAtPath(folder, withIntermediateDirectories: true, attributes: nil)
            } catch {}
        }
    }
    
    static func saveImage(image: UIImage, name: String) {
        let fileManager = NSFileManager.defaultManager()
        let dir: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        print(dir)
        let path = dir.stringByAppendingPathComponent(name + ".png")
        if !fileManager.fileExistsAtPath(path){
            autoreleasepool {
                let data = UIImagePNGRepresentation(image)
                data?.writeToFile(path, atomically: true)
            }
        }
    }
    
    static func createPlistFileInDocument(foderName: String, plistName: String, dict: NSDictionary) {
        let fileManager = NSFileManager.defaultManager()
        let dir: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let path = dir.stringByAppendingPathComponent(foderName + "/" + plistName + ".plist")
        if !fileManager.fileExistsAtPath(path){
            dict.writeToFile(path, atomically: true)
        }
    }
    
}