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
    var imageCarouselDataSource : ImageCarouselDataSource!
    var currentFocusedCaroucelIndex = 0
    var normalCaroucelItemSize = CGSize(width: 0, height: 0)
    var videoFeedCellSize = CGSize(width: 0, height: 0)
    let enLargeScale = 1.2
    
    let topSpacing = 64
    let horizontalSpacing = 10

    public static let videoFeedViewCellKey = "videoFeedViewCellKey"
    public static let imageCarouselCellKey = "imageCarouselCellKey"
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
                
        setupVideoFeedView()
        setupCarouselView()
    }
    
    func setupVideoFeedView() {
        let videoFeedlayout = UICollectionViewFlowLayout()
        videoFeedlayout.scrollDirection = .horizontal
        videoFeedlayout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        videoFeedCellSize = videoFeedlayout.itemSize
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
    
    func setupCarouselView() {
        let imageCarouselLayout = UICollectionViewFlowLayout()
        imageCarouselLayout.scrollDirection = .horizontal
        let itemWidth = floor(view.bounds.width/3)
        let itemHeight = floor(view.bounds.height/3)
        normalCaroucelItemSize = CGSize(width: itemWidth, height: itemHeight)
        imageCarouselLayout.itemSize = normalCaroucelItemSize
        let y = videoFeedView.frame.height + videoFeedView.frame.origin.y + CGFloat(horizontalSpacing)
        imageCarouselView = UICollectionView(frame: CGRect(x: 0, y: y, width: self.view.bounds.width, height: itemHeight), collectionViewLayout:imageCarouselLayout);
        imageCarouselView.backgroundColor = UIColor.red
        videoFeedView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        imageCarouselDataSource = ImageCarouselDataSource()
        imageCarouselView.register(CarouselViewCell.self, forCellWithReuseIdentifier: VideoDisplayViewController.imageCarouselCellKey)
        imageCarouselView.dataSource = imageCarouselDataSource
        imageCarouselView.showsHorizontalScrollIndicator = false
        self.view.addSubview(imageCarouselView)
        let inset = 1 * itemWidth
        imageCarouselView.contentOffset = CGPoint(x:inset, y: 0)
        imageCarouselView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        imageCarouselView.delegate = self
        imageCarouselView.clipsToBounds = false
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data = [
            VideoData(id: 1,
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
                      videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
            VideoData(id: 2, 
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
                      videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
            VideoData(id: 3, 
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
                      videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
            VideoData(id: 4, 
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
                      videoURL: "http://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
            VideoData(id: 5,
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
                      videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
            VideoData(id: 6,
                      imageURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
                      videoURL: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")]
        videoFeedDataSource.videoDataArray = data
        imageCarouselDataSource.videoDataArray = data
        videoFeedView.reloadData()
        imageCarouselView.reloadData()
    }
    
    func updateFocusedCarousel(index: Int) {
        if (currentFocusedCaroucelIndex != index) {
            currentFocusedCaroucelIndex = index
            imageCarouselView.performBatchUpdates(nil, completion: nil)
        }
    }
}

extension VideoDisplayViewController : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView === self.imageCarouselView) {
            if (indexPath.row == currentFocusedCaroucelIndex) {
                return CGSize(width:normalCaroucelItemSize.width * enLargeScale, height:normalCaroucelItemSize.height * enLargeScale)
            } else {
                return normalCaroucelItemSize
            }
        } else {
            return videoFeedCellSize
        }
    }
}

extension VideoDisplayViewController : UICollectionViewDelegate {
    
    func scrollToCurrentCenterItem(collectionView: UICollectionView, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = collectionView.contentOffset
        var indexes = collectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = collectionView.cellForItem(at: index)!
        let position = collectionView.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width/2{
            index.row = index.row+1
        }
        collectionView.scrollToItem(at: index, at: .left, animated: true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (scrollView === videoFeedView) {
            scrollToCurrentCenterItem(collectionView: videoFeedView, targetContentOffset: targetContentOffset)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView === imageCarouselView) {
            var indexes = imageCarouselView.indexPathsForVisibleItems
            indexes.sort()
            var centralCellIndex = 0
            var centralCellDiff = 100000.0
            for index in indexes {
                let cell = imageCarouselView.cellForItem(at: index)!
                
                let centerX = cell.center.x - imageCarouselView.contentOffset.x
                let diff = abs(centerX - imageCarouselView.bounds.width/2)
                if (diff < centralCellDiff) {
                    centralCellIndex = index.row
                    centralCellDiff = diff
                }
            }
            updateFocusedCarousel(index: centralCellIndex)
        }
    }
}
