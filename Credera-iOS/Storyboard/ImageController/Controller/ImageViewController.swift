//
//  ImageViewController.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/23/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit
class ImageViewController: UIViewController, UIScrollViewDelegate, NavigationHelper {
    
    public class var storyboardName: String { return "ImageScrollView" }
    public class var viewControllerID: String { return "ImageViewController" }
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var commitGiphyDetails: CommitGiphyDetails!
    
    public static func getInstance(commitGiphyDetails: CommitGiphyDetails) -> UIViewController {
        guard let imageViewController = getInstance() as? ImageViewController else {
            return UIViewController()
        }
        imageViewController.commitGiphyDetails = commitGiphyDetails
        return imageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(data: commitGiphyDetails!.imageData))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 5.0
        view.addSubview(scrollView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
