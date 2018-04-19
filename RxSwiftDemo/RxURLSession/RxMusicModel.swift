//
//  RxMusicModel.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/13.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import ObjectMapper

////豆瓣接口模型
//class Douban: Mappable {
//    //频道列表
//    var channels: [Channel]?
//
//    init(){
//    }
//
//    required init?(map: Map) {
//    }
//
//    // Mappable
//    func mapping(map: Map) {
//        channels <- map["channels"]
//    }
//}
//
////频道模型
//class Channel: Mappable {
//    var name: String?
//    var nameEn:String?
//    var channelId: String?
//    var seqId: Int?
//    var abbrEn: String?
//
//    init(){
//    }
//
//    required init?(map: Map) {
//    }
//
//    // Mappable
//    func mapping(map: Map) {
//        name <- map["name"]
//        nameEn <- map["name_en"]
//        channelId <- map["channel_id"]
//        seqId <- map["seq_id"]
//        abbrEn <- map["abbr_en"]
//    }
//}

//豆瓣接口模型
struct Douban: Mappable {
    //频道列表
    var channels: [Channel]?
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        channels <- map["channels"]
    }
}

//频道模型
struct Channel: Mappable {
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}

//歌曲列表模型
struct Playlist: Mappable {
    var r: Int!
    var isShowQuickStart: Int!
    var song:[Song]!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        r <- map["r"]
        isShowQuickStart <- map["is_show_quick_start"]
        song <- map["song"]
    }
}

//歌曲模型
struct Song: Mappable {
    var title: String!
    var artist: String!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        title <- map["title"]
        artist <- map["artist"]
    }
}
