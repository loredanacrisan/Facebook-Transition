//
//  ViewController.swift
//  Facebook-Transition
//
//  Created by Loredana Crisan on 10/4/14.
//  Copyright (c) 2014 Loredana Crisan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var feedScrollView: UIScrollView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tabBarImageView: UIImageView!
    @IBOutlet var actionBarImageView: UIImageView!
    @IBOutlet var searchBarImageView: UIImageView!
    @IBOutlet var feedImageView: UIImageView!

    
    // Create a variable for the image
    var tapTargetImageView: UIImageView!
    
    // Create a variable for the transition
    var transition: TransitionManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up scroll view
        feedScrollView.contentSize = feedImageView.frame.size
        feedScrollView.contentInset.bottom = tabBarImageView.frame.height
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    // get ready for segue
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
        
        // assign view controllers as source and destination
        var destinationViewController = segue.destinationViewController as PhotoDetailViewController
        var sourceViewController = segue.sourceViewController as ViewController
        
        // assign image to destination controller
        destinationViewController.image = tapTargetImageView.image
        
        // assign transition and transition image
        transition = TransitionManager()
        transition.tapTargetImageView = tapTargetImageView
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = transition
        

        
    }
  
    
    
    // perform seque on tap
    @IBAction func onPhotoTap(tapGesture: UITapGestureRecognizer) {
        tapTargetImageView = tapGesture.view as UIImageView
        performSegueWithIdentifier("photoDetailSegue", sender: self)
    }
    
}


