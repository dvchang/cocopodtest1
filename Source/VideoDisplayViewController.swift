//
//  VideoDisplayViewController.swift
//  videoUI2
//
//  Created by David Chang on 12/15/23.
//

import Foundation

public class VideoDisplayViewController: UIViewController {
    
    var videoFeedView: UICollectionView!
    var videoFeedDataSource: VideoViewDataSource!
    var imageCarouselView: UICollectionView!
    
    let topSpacing = 64
    let horizontalSpacing = 10

    public static let videoFeedViewCellKey = "videoFeedViewCellKey"

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
                
        setupVideoFeedView()
        
        let imageCarouselLayout = UICollectionViewFlowLayout()
        imageCarouselLayout.scrollDirection = .horizontal
        imageCarouselLayout.itemSize = CGSize(width: view.bounds.width, height: (view.bounds.width)/3)
        let y = videoFeedView.frame.height + videoFeedView.frame.origin.y + CGFloat(horizontalSpacing)
        imageCarouselView = UICollectionView(frame: CGRect(x: 0, y: y, width: self.view.bounds.width, height: self.view.bounds.width * 0.66), collectionViewLayout:imageCarouselLayout);
        imageCarouselView.backgroundColor = UIColor.red
        self.view.addSubview(imageCarouselView)
    }
    
    func setupVideoFeedView() {
        let videoFeedlayout = UICollectionViewFlowLayout()
        videoFeedlayout.scrollDirection = .horizontal
        videoFeedlayout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        videoFeedlayout.minimumLineSpacing = 0
        videoFeedView = UICollectionView(frame: CGRect(x: 0, y: CGFloat(topSpacing), width: self.view.bounds.width, height: self.view.bounds.width), collectionViewLayout:videoFeedlayout);
        videoFeedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoFeedView.backgroundColor = UIColor.yellow
        videoFeedView.register(VideoFeedViewCell.self, forCellWithReuseIdentifier: VideoDisplayViewController.videoFeedViewCellKey)
        videoFeedDataSource = VideoViewDataSource()
        videoFeedView.dataSource = videoFeedDataSource
        videoFeedView.showsHorizontalScrollIndicator = false
        self.view.addSubview(videoFeedView)
        videoFeedView.delegate = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)    
        videoFeedDataSource.videoDataArray = [
            VideoData(id: 1, imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
            VideoData(id: 2, imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg", videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
            VideoData(id: 3, imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg", videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")]
        videoFeedView.reloadData()
    }
}

extension VideoDisplayViewController : UICollectionViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (scrollView === self.videoFeedView) {
            targetContentOffset.pointee = scrollView.contentOffset
            var indexes = self.videoFeedView.indexPathsForVisibleItems
            indexes.sort()
            var index = indexes.first!
            let cell = self.videoFeedView.cellForItem(at: index)!
            let position = self.videoFeedView.contentOffset.x - cell.frame.origin.x
            if position > cell.frame.size.width/2{
                index.row = index.row+1
            }
            self.videoFeedView.scrollToItem(at: index, at: .left, animated: true )
        }
    }
}
