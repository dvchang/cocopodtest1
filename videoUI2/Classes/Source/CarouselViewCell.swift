//
//  CarouselViewCell.swift
//  videoUI2
//
//  Created by David Chang on 12/16/23.
//

import UIKit
import Alamofire
import AlamofireImage

class CarouselViewCell : UICollectionViewCell {
    
    let imageView : UIImageView = UIImageView()
    var videoData : VideoData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = self.contentView.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
                
    func setData(data: VideoData) {
        videoData = data
                
        guard !data.imageURL.isEmpty else {
            return
        }
        
        AF.request(data.imageURL).responseImage {
            [weak self] (response) in
            guard let strongSelf = self else {
                            return
                        }
            guard strongSelf.videoData?.imageURL == data.imageURL else {
                return
            }
            switch response.result {
            case .success(let image):
                strongSelf.imageView.image = image
            case .failure(_):
                break
            }
        }
    }    
    
}
