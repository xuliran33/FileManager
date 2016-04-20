//
//  FirstViewController.swift
//  
//
//  Created by gdj003 on 16/4/20.
//
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDocumentsPath(sender: UIButton) {
        let fileManager = NSFileManager()
        // 搜索iOS文件系统中,沙箱里面指定类型的目录
        // URLsForDirectory: 我们希望搜索的目录
        // inDomains搜索目录的位置-UserDomainMask(在当前用户目录下搜索)
        // 将搜索到的数据转化为数组
        let urls = fileManager.URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask) as! [NSURL]
        if urls.count > 0{
            let documentsFolder = urls[0]
            println("\(documentsFolder)")
        }else{
            println("没有找到 Documents 目录")
        }
    }
    
    @IBAction func getTempPath(sender: UIButton) {
        let fileManager = NSFileManager()
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
        if urls.count > 0{
            let cacheFolder = urls[0]
            println(cacheFolder)
        }else{
            println("没有找到Caches目录")
        }
    }
    
    @IBAction func getCachesPath(sender: UIButton) {
        // 获取temp路径
        
        if let tempDirectory = NSTemporaryDirectory(){
            println("\(tempDirectory)")
        }else{
            println("没有找到temp目录")
        }
    }
    
    @IBAction func enumerating(sender: UIButton) {
        var error: NSError?
        let fileManager = NSFileManager()
        let bundleDir = NSBundle.mainBundle().bundlePath
        let bundleContents = fileManager.contentsOfDirectoryAtPath(bundleDir, error: &error)
        if let contents = bundleContents{
            if contents.count == 0{
                println("应用程序包是空的!")
            }else{
                println("应用程序包中的内容 = \(bundleContents!)")
            }
        }else if let theError = error{
            println("不能读应用程序包的内容error = \(error!)")
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
