//
//  DouBanNetworkService.swift
//  RxSwiftDemo
//
//  Created by WhatsXie on 2018/4/19.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import RxSwift
import RxCocoa
import ObjectMapper

class DouBanNetworkService {
    //获取频道数据
    func loadChannels() -> Observable<[Channel]> {
        return DouBanProvider.rx.request(.channels)
            .mapObject(Douban.self)
            .map{ $0.channels ?? [] }
            .asObservable()
    }
    
    //获取歌曲列表数据
    func loadPlaylist(channelId:String) -> Observable<Playlist> {
        return DouBanProvider.rx.request(.playlist(channelId))
            .mapObject(Playlist.self)
            .asObservable()
    }
    
    //获取频道下第一首歌曲
    func loadFirstSong(channelId:String) -> Observable<Song> {
        return loadPlaylist(channelId: channelId)
            .filter{ $0.song.count > 0 }
            .map{ $0.song[0] }
    }
}

