//
//  ImageDetailViewController.swift
//  ShoppingApp
//
//  Created by Aniket Patil on 18/01/23.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {

    var scrollV : UIScrollView!
    var imageView : UIImageView!
    
    var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollV = UIScrollView()
        scrollV.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollV.minimumZoomScale = 1
        scrollV.maximumZoomScale = 3
        scrollV.bounces = false
        scrollV.delegate = self
        self.view.addSubview(scrollV)
        imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: image), completed: nil)
        imageView.frame = CGRect(x: 0, y: 0, width: scrollV.frame.width, height: scrollV.frame.height)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleToFill
        scrollV.addSubview(imageView)
   }

   func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
   }

}
