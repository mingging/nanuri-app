//
//  Names.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/17.
//

import Foundation

enum XibName {
    static let productCustomCell = "ProductCustomCell"
    static let noticeCustomCell = "NoticeCustomCell"
    static let commentCustomCell = "CommentCustomCell"
    static let replyCustomCell = "ReplyCustomCell"
}

enum ImageName {
    static let searchIcon = "search_icon"
    static let noticeIcon = "notice_icon"
}

enum StoryboardID {
    static let notice = "notice"
    static let productDetail = "productDetail"
}

enum Stoyboard: String {
    case notice = "Notice"
    case productDetail = "ProductDetail"
    case pay = "Pay"
    
    var name: String {
        return rawValue
    }
    
    var id: String {
        return "\(self)"
    }
}
