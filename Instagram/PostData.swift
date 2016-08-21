//
//  PostData.swift
//  
//
//  Created by Musashi Raijin on 2016/08/16.
//
//

import UIKit
import Firebase
import FirebaseDatabase


class PostData: NSObject {
    
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    // コメント投稿者名
    var commentsName: String = "０人"
    
    // 投稿されたコメント
    var comments: String = "コメントなし"
    
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        
        // デバッグ用
        print("\(valueDictionary.description)")
        
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDictionary["name"] as? String
        
        caption = valueDictionary["caption"] as? String
        
        
        
        // コメント入力した人の表示名
        if let commentsName = valueDictionary["commentsName"] as? String {
            self.commentsName = commentsName
        }

        // 入力されたコメントの辞書
        if let comments = valueDictionary["comments"] as? String {
            self.comments = comments
        }
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDictionary["time"] as! NSTimeInterval)
    }

}
