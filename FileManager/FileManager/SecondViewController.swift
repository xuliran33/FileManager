//
//  SecondViewController.swift
//  
//
//  Created by gdj003 on 16/4/20.
//
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var content: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 将字符串写到指定文件中
    @IBAction func saveToDisk(sender: UIButton) {
        let text = textField.text
        let destinationPath = NSTemporaryDirectory() + "myFile.txt"
        var error : NSError?
        let writen = text.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        if writen{
            println("成功存储文件到\(destinationPath)中")
        }else{
            if let theError = error{
                println("发生了错误:\(theError)")
            }
        }
    }
    // 读取文件中的字符串
    @IBAction func displayContent(sender: UIButton) {
        var error: NSError?
        let path = NSTemporaryDirectory() + "myFile.txt"
        let readString = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        self.content.text = "myFile.txt文件中的字符串为: \(readString!)"
    }
    // 写入/读取数组
    @IBAction func saveArrayToDisk(sender: UIButton) {
        let path = NSTemporaryDirectory() + "mySrrayFile.txt"
        let arrayOfNames: NSArray = ["Steve", "John", "Edward"]
        if arrayOfNames.writeToFile(path, atomically: true){
            let readArray: NSArray? = NSArray(contentsOfFile: path)
            if let array = readArray{
                println("成功读取数组\(array)")
            }else{
                println("读取数组失败")
            }
        }
    }
    // 在磁盘上创建目录
    @IBAction func creatDirectory(sender: UIButton) {
        let tempPath = NSTemporaryDirectory()
        let imagesPath = tempPath.stringByAppendingPathComponent("images")
        var error: NSError?
        let fileManager = NSFileManager()
        if fileManager.createDirectoryAtPath(imagesPath, withIntermediateDirectories: true, attributes: nil, error: nil){
            println("目录创建成功")
        }else{
            println("目录创建失败")
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
