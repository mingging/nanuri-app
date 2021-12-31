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
    static let mypageCustomCell = "MyPageCustomCell"
}

enum ImageName {
    static let searchIcon = "search_icon"
    static let noticeIcon = "notice_icon"
}

enum StoryboardID {
    static let home = "home"
    static let notice = "notice"
    static let search = "search"
    static let productDetail = "productDetail"
    static let mypageDetail = "mypageDetail"
    static let comment = "comment"
}

enum Stoyboard: String {
    case homeView = "Home"
    case listView = "List"
    case notice = "Notice"
    case search = "Search"
    case productDetail = "ProductDetail"
    case mypageDetail = "MypageDetail"
    case pay = "Pay"
    case addProduct = "AddProduct"
    case comment = "Comment"
    
    var name: String {
        return rawValue
    }
    
    var id: String {
        return "\(self)"
    }
}

enum APIHost: String {
    case url = "http://20.196.209.221:8000/"
}

enum APIInfo: String {
    case product = "product/"
}
