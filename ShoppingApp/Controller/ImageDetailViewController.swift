//
//  ImageDetailViewController.swift
//  ShoppingApp
//
//  Created by Aniket Patil on 18/01/23.
//

import UIKit
import SDWebImage

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: URL(string: image), completed: nil)
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
         if scrollView.zoomScale > 1 {
             if let image = imageView.image {
                 let ratioW = imageView.frame.width / image.size.width
                 let ratioH = imageView.frame.height / image.size.height
                 let ratio = ratioW < ratioH ? ratioW : ratioH
                 let newWidth = image.size.width * ratio
                 let newHeight = image.size.height * ratio
                 let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                 let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                 let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                 let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                 scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
             }
         } else {
             scrollView.contentInset = .zero
         }
     }
}
