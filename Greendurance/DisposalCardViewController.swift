//
//  DisposalCardViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 5/16/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class DisposalCardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var trashImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.contentSize = self.trashImageView.frame.size
        self.scrollView.delegate = self
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.trashImageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
}
