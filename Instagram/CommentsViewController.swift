//
//  CommentsViewController.swift
//  Instagram
//
//  Created by Musashi Raijin on 2016/08/18.
//  Copyright © 2016年 masahiro.kitamura. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class CommentsViewController: UIViewController {
    
    
    // コメント投稿者名
    @IBOutlet weak var commentsInputName: UITextField!
    
    // コメント文
    @IBOutlet weak var commentsTextField: UITextField!
    
    var image: UIImage?
    var name: String?
    var caption: String?
    var textField: UITextField!
    
    let indexPath: Int = 0
    var postArray: [PostData] = []

    
    @IBAction func commentsPostButton(sender: AnyObject) {
        
        
        let postRef = FIRDatabase.database().reference()
        
        // 辞書を作成してFirebaseに保存する
        let postData = ["caption": textField.text!, "image": image!, "name": name!, "commentsName": commentsInputName.text!, "comments": commentsTextField.text!]
        
        postRef.childByAutoId().setValue(postData)
        
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func commentsCancelButton(sender: AnyObject) {
        
        // 画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
