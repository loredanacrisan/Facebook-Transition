//
//  PhotoDetailViewController.swift
//  Facebook-Transition
//
//  Created by Loredana Crisan on 10/4/14.
//  Copyright (c) 2014 Loredana Crisan. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    
    var image: UIImage!
    var scrollThreshold: Bool! = false
    var scrollAlpha: CGFloat! = 1.0
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var doneImageView: UIImageView!
    @IBOutlet var photoActionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        scrollView.contentSize = self.view.frame.size
        scrollView.delegate = self
        scrollView.bounces = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Dismiss if user presses done
    @IBAction func onDoneTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        var offset = abs(Float(scrollView.contentOffset.y))
        
 
        //set background color for the view based on scroll offset
        if (offset <= 100) {
            scrollAlpha = 1 - (CGFloat(offset)/100)
        } else if (offset > 100){
            scrollThreshold = true
            scrollAlpha = 0
        }
       

        self.view.backgroundColor = UIColor(white: 0, alpha: scrollAlpha)
        doneImageView.alpha = scrollAlpha * 2
        photoActionImageView.alpha = scrollAlpha * 2
        
        
    }
    

    //on scroll end, dismiss if treshold is met
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            
            if (scrollThreshold == true) {
                dismissViewControllerAnimated(true, completion: nil)
            }
            
    }
    
    

    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
