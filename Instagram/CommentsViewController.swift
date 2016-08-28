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
    
    var postArray: [PostData] = []
    
    @IBAction func commentsPostButton(sender: AnyObject) {
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccessWithStatus("投稿しました")
    }
    

    @IBAction func commentsCancelButton(sender: AnyObject) {
        
        // 画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
        
        
        }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        // 全てのモーダルを閉じる
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        super.viewWillDisappear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.postData.id = snapshot.key
        
        self.postData.commentsName = commentsInputName.text!
        self.postData.comments = commentsTextField.text!
        
        
        self.postRef = FIRDatabase.database().reference()
        
        
        FIRDatabase.database().reference().child(CommonConst.PostPATH).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            // PostDataクラスを生成して受け取ったデータを設定する
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                let postData = PostData(snapshot: snapshot, myId: uid)
//                self.postArray.insert(postData, atIndex: 0)
                
            if var commentsName = snapshot.value!.objectForKey("commentsName") as? String,
                    comments = snapshot.value!.objectForKey("comments") as? String {
                    
                    let post = ["commentsName": self.postData.commentsName, "comments": self.postData.comments]
                    
                    self.postRef.childByAutoId().setValue(post)
                    
                }

                
                
            }
        })

 
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
