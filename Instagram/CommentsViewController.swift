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
    
    var image: UIImage!
    
    // コメント投稿時に投稿する画像を表示
    @IBOutlet weak var commentsImageView: UIImageView!
    
    // コメント文
    @IBOutlet weak var commentsTextView: UITextView!

    @IBAction func commentsPostButton(sender: AnyObject) {
        
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
        
        // ImageViewから画像を取得する
//        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        
        // NSUserDfaultsから表示名を取得する
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        // 時間を取得する
//        let time = NSDate.timeIntervalSinceReferenceDate()
        
        // 辞書を作成してFirebaseに保存する
        let postData = ["name": name, "comments": commentsTextView.text!]
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
        
        // 受け取った画像をImageViewに設定する
        commentsImageView.image = image

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
