//
//  DataSrouce.swift
//  videoUI2
//
//  Created by David Chang on 12/16/23.
//

import Foundation

class VideoViewDataSource : NSObject, UICollectionViewDataSource {
    var source : DataSource
    
    init(source: DataSource) {
        self.source = source
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? source.numberOfItem() : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoDisplayViewController.videoFeedViewCellKey, for: indexPath)
        if let videoCell = cell as? VideoFeedViewCell {
            videoCell.setData(data:source.dataAtIndex(indexPath.row))
        }
        return cell
    }
}

class ImageCarouselDataSource : NSObject, UICollectionViewDataSource {
    var source : DataSource
    
    init(source: DataSource) {
        self.source = source
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? source.numberOfItem() : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoDisplayViewController.imageCarouselCellKey, for: indexPath)
        if let imageCell = cell as? CarouselViewCell {
            imageCell.setData(data:source.dataAtIndex(indexPath.row))
        }
        return cell
    }
}

class DataSource {
    var dataArray : [VideoData] = []
    
    func parseData(_ data:[(String, String)]) {
        var array : [VideoData] = []
        for i in 0...data.count - 1 {
            let pair = data[i]
            let newData = VideoData(id: i, imageURL: pair.0, videoURL: pair.1)
            array.append(newData)
        }
        dataArray = array
    }
    
    func numberOfItem() -> Int {
        return dataArray.count
    }
    
    func dataAtIndex(_ index: Int) -> VideoData {
        return dataArray[index]
    }
}

