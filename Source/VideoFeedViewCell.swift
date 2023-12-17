//
//  VideoFeedViewCell.swift
//  videoUI2
//
//  Created by David Chang on 12/16/23.
//

import Foundation
import AVFoundation
import CoreMedia

class VideoFeedViewCell : UICollectionViewCell {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
        
    func setData(data: VideoData) {
        self.backgroundColor = UIColor.white
        let url = URL(string:data.videoURL)
        guard url != nil else {
            return
        }
        player = AVPlayer(url:url!)
        playerLayer = AVPlayerLayer(player: player)
        
        layer.addSublayer(playerLayer!)
        
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspect
        play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    override func prepareForReuse() {
        if (player?.currentItem != nil) {
            NotificationCenter.default.removeObserver(player!.currentItem!)
        }
        super.prepareForReuse()
        pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
    }
    
}
