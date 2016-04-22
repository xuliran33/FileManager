//
//  ThiedViewController.swift
//  
//
//  Created by gdj003 on 16/4/22.
//
//

import UIKit

class ThiedViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func enumeratingApp(sender: AnyObject) {
        self.content.text = ""
        let appBundleContents = contentsOfAppBundle()
        for url in appBundleContents{
            printUrlPropertiesToTextView(url)
        }
    }
    // 搜索.app目录中所有条目
    func contentsOfAppBundle() -> [NSURL]{
        let propertiesToGet = [
            NSURLIsDirectoryKey,
            NSURLIsReadableKey,
            NSURLCreationDateKey,
            NSURLContentAccessDateKey,
            NSURLContentModificationDateKey
        ]
        
        var error: NSError?
        let fileManager = NSFileManager()
        let bundleURL = NSBundle.mainBundle().bundleURL
        let result = fileManager.contentsOfDirectoryAtURL(bundleURL, includingPropertiesForKeys: propertiesToGet, options: nil, error: &error) as! [NSURL]
        
        if let theError = error{
            println(theError)
        }
    return result
    
    }

    func printUrlPropertiesToTextView(url: NSURL){
        self.content.text = self.content.text + "URL name = \(url.lastPathComponent)\n"
        self.content.text = self.content.text + "Is a Directory? \(isUrlDirectory(url))\n"
        self.content.text = self.content.text + "Is Readable?\(isUrlReadable(url))\n"
        if let creationDate = dateOfType(NSURLCreationDateKey, url: url){
            self.content.text = self.content.text + "\(creationDate)\n"
        }
        if let accessDate = dateOfType(NSURLContentAccessDateKey, url: url){
            self.content.text = self.content.text + "\(accessDate)\n"
        }
        if let modificationDate = dateOfType(NSURLContentModificationDateKey, url: url){
            self.content.text = self.content.text + "\(modificationDate)\n"
        }
        
        self.content.text = self.content.text + "-----------------------\n\n\n"
    }
    
    func stringValueOfBoolProperty(property: String, url: NSURL) -> String{
        var value: AnyObject?
        var error: NSError?
        if url.getResourceValue(&value, forKey: property, error: &error) && value != nil{
            let number = value as! NSNumber
            
            return number.boolValue ? "YES" : "NO"
        }
        return "NO"
    }
    
    func isUrlReadable(url: NSURL) -> NSString{
        return stringValueOfBoolProperty(NSURLIsReadableKey, url: url)
    }
    
    // 将获取的类型转为NSDate然后返回
    func dateOfType(type: String, url: NSURL) -> NSDate?{
        var value: AnyObject?
        var error: NSError?
        if url.getResourceValue(&value, forKey: type, error: &error) && value != nil{
            return value as? NSDate
        }
        return nil
    }
    
    // 检查指定的url是否是目录
    func isUrlDirectory(url: NSURL) -> String{
        return stringValueOfBoolProperty(NSURLIsDirectoryKey, url: url)
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
