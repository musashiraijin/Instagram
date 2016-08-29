//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Musashi Raijin on 2016/08/16.
//  Copyright © 2016年 masahiro.kitamura. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    // コメント表示欄
    @IBOutlet weak var commentsLabel: UILabel!
    
    // コメント投稿ボタンのアウトレット
    @IBOutlet weak var commentsInput: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // 表示されるときに呼ばれるメソッドをオーバーライドしてデータをUIに反映する
    func setPostData(postData: PostData) {
        
        postImageView.image = postData.image
        captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(postData.date!)
        dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        //コメント
        var commentsText: String = ""
        // (課題)コメント者と名前を追加
        for i in 0..<postData.comments.count {
            commentsText = commentsText + postData.comments[i]["name"]! + " : " + postData.comments[i]["comment"]! + "\n"
        }
        commentsLabel.text = commentsText
        
    }
    
}
