//
//  ViewController.swift
//  QQGames
//
//  Created by 黄海燕 on 15/12/6.
//  Copyright © 2015年 Haiyan Huang. All rights reserved.
//


//1.界面
//2.播放引擎
//3.pip
import UIKit
import AVKit
import AVFoundation

var currentItemStatus = "currentItem.status"
var mcontext = 0
class ViewController: UIViewController,AVPictureInPictureControllerDelegate {

    lazy var player:AVPlayer = {
        let p = AVPlayer()
        p.addObserver(self, forKeyPath: currentItemStatus, options: .New, context: &mcontext)
        return p
    }()
    
    @IBOutlet var pipView: PhpVideoPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let imageView:UIImageView = UIImageView();
//        imageView.frame = self.view.frame
//        imageView.image = UIImage(named:"1")
//        self.view.addSubview(imageView)
        let u = NSBundle.mainBundle().URLForResource("mp", withExtension: "mp4")
        let asset = AVAsset(URL: u!)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItemWithPlayerItem(item)
        pipView.pipPlayerPlay = player
        player.play()
    }
    
    var pipcontroller:AVPictureInPictureController?
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(keyPath == currentItemStatus){
            let statusInt = change?[NSKeyValueChangeNewKey] as? NSNumber
            let status = AVPlayerItemStatus(rawValue: statusInt!.integerValue)
            if(status != .ReadyToPlay){
                return
            }
            pipcontroller = AVPictureInPictureController(playerLayer: pipView.pipiplayer)
            pipcontroller?.delegate = self
        }
    }
    func pictureInPictureControllerWillStartPictureInPicture(pictureInPictureController: AVPictureInPictureController) {
        print("will start")
    }
    
    func pictureInPictureControllerDidStartPictureInPicture(pictureInPictureController: AVPictureInPictureController) {
        print("did start")
    }
    
    func pictureInPictureController(pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: NSError) {
        print("failedToStart")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

