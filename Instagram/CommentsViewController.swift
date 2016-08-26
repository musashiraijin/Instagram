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
    var imageString: UIImage?
    var name: String?
    var caption: String?
    var textField: UITextField!
    var likes: [String] = []
    var time = NSDate.timeIntervalSinceReferenceDate()
    
    var commentsName: String?
    var comments: String?
    
    var indexPathSegue = 0
    
    var postRef: FIRDatabaseReference!
    
    var postData: PostData!
    
    @IBAction func commentsPostButton(sender: AnyObject) {
        
        // 辞書を作成してFirebaseに保存する
        let post = ["commentsName": commentsInputName, "comments": commentsTextField]
        
        self.postRef.child(CommonConst.PostPATH).setValue(post)
        
        
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
        
//        self.postData.id = snapshot.key
        
        self.postRef = FIRDatabase.database().reference()
        
        self.postRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let commentsName = snapshot.value!.objectForKey("commentsName") as? String,
                       comments = snapshot.value!.objectForKey("comments") as? String {
                
            }
            
        })
        
//        commentsName = postData.commentsName
//        comments = postData.comments
        
        
//        titleTextField.text = task.title
//        contentsTextView.text = task.contents
        
        // Taskクラスのカテゴリ入力欄を追加。
//        categoryTextField.text = task.category
        
//        datePicker.date = task.date
        
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
