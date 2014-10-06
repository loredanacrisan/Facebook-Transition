//
//  TransitionManager.swift
//  Facebook-Transition
//
//  Created by Loredana Crisan on 10/5/14.
//  Copyright (c) 2014 Loredana Crisan. All rights reserved.
//


import UIKit


class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
 
    
    var isPresenting: Bool = true
    var tapTargetImageView: UIImageView!

    

    
    
    // return how many long the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animator when presenting from the viewcontroller
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    // return the animator used when dismissing from the photo detail controller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }

    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // set up to/from view controllers and container view for animation
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)

        // set up window view and set image to be transformed in window view
        var window = UIApplication.sharedApplication().keyWindow
        var imageFrame = window.convertRect(tapTargetImageView.frame, fromView: tapTargetImageView.superview)
        
        // set up transition from newsfeed to photo detail
        if (isPresenting) {
            containerView.addSubview(toViewController!.view)
            toViewController!.view.alpha = 0
            
            var transitionImageView = UIImageView(image: tapTargetImageView.image)
            transitionImageView.frame = imageFrame
            transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
            transitionImageView.clipsToBounds = true
            window.addSubview(transitionImageView)
            
            var destinationImageView = (toViewController as PhotoDetailViewController).imageView
            
            
            
            //calculate where destination image frame should going to be
            var detailFrame: CGRect!

            
            if (destinationImageView.image!.size.width == 480) {
                detailFrame = CGRect(x: 0, y: 150, width: 320, height: 214)

            } else
            {
                detailFrame = CGRect(x: 0, y: 50, width: 320, height: 480)

            }
            
            //sets where the destination image frame should be
            destinationImageView.frame = detailFrame
            destinationImageView.hidden = true

            
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 2, options: nil, animations: { () -> Void in
                toViewController!.view.alpha = 1
                transitionImageView.frame = detailFrame
             
                
                }) { (finished: Bool) -> Void in
                    destinationImageView.hidden = false
                    transitionImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
  
            
        // set up transition from detail view to newsfeed
        } else {
            
            //get source scroll View Offset
            var sourceScrollViewOffsetY = (fromViewController as PhotoDetailViewController).scrollView.contentOffset.y

            //set the transition image
            var sourceImageView = (fromViewController as PhotoDetailViewController).imageView
            var transitionImageView = UIImageView(image: sourceImageView.image)
            
            //set transition image frame and add it to window
            transitionImageView.frame = CGRect(x: sourceImageView.frame.origin.x, y: sourceImageView.frame.origin.y - sourceScrollViewOffsetY, width: sourceImageView.frame.width, height: sourceImageView.frame.height)
            transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
            transitionImageView.clipsToBounds = true
            window.addSubview(transitionImageView)

            //hide the original image
            sourceImageView.hidden = true
            fromViewController!.view.alpha = (fromViewController as PhotoDetailViewController).scrollAlpha
        
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 2, options: nil, animations: { () -> Void in
                transitionImageView.frame = imageFrame
                
                fromViewController!.view.alpha = 0
                }, completion: { (Bool) -> Void in
                    transitionImageView.removeFromSuperview()
                    fromViewController!.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
        
        
    }

}
