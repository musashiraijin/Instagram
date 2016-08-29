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
    
    
    var postData:PostData!
    
    // コメント文
    @IBOutlet weak var commentsTextField: UITextField!
    
    
    @IBAction func commentsPostButton(sender: AnyObject) {
        
        /// Firebaseに保存するデータの準備
        //現在のユーザーのユニークIDを取得
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            if let displayName = FIRAuth.auth()?.currentUser?.displayName {
                
                let comment = ["uid": uid, "name": displayName, "comment": commentsTextField.text!]
                postData.comments.append(comment)
                let imageString = postData.imageString
                let name = postData.name
                let caption = postData.caption
                let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
                let likes = postData.likes
                let comments = postData.comments
                
                //辞書を作成してFirebaseに保存する
                let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes, "comments": comments]
                print(postData.comments)
                
                let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
                postRef.child(postData.id!).setValue(post)
            }
        }
        
        //CommentsViewControllerを閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( postData.id)
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する。
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(CommentsViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)

 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
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
