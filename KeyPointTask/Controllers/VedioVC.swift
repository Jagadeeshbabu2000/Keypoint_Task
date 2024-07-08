//////
//////  VedioVC.swift
//////  KeyPointTask
//////
//////  Created by Jagadeesh on 06/07/24.
//////
////
import UIKit
import AVKit
import AVFoundation

class VedioVC: UIViewController, AVPlayerViewControllerDelegate {
    
    var vedioplayer:[YouTubeModel] = []
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let videoURLString = vedioplayer.first?.videoURL,
              let videoURL = URL(string: videoURLString) else {return}
        player = AVPlayer(url: videoURL)
              playerLayer = AVPlayerLayer(player: player)
              playerLayer?.frame = view.bounds
              view.layer.addSublayer(playerLayer!)
              player?.play()
          }
          override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()
              playerLayer?.frame = view.bounds
          }
          deinit {
              player?.pause()
          }
        
    }

