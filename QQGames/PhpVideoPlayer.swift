//
//  PhpVideoPlayer.swift
//  QQGames
//
//  Created by 黄海燕 on 15/12/6.
//  Copyright © 2015年 Haiyan Huang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PhpVideoPlayer: UIView {

    override class func layerClass()->AnyClass{
        return AVPlayerLayer.self
    }
    
    var pipiplayer:AVPlayerLayer{
        return layer as! AVPlayerLayer
    }
    
    var pipPlayerPlay:AVPlayer?{
        get{
            return pipiplayer.player
        }
        set{
            pipiplayer.player = newValue
        }
    }

}
