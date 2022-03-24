//
//  AnimationController.swift
//  WeekChallenge
//
//  Created by shoh on 2022/03/17.
//

import UIKit

class AnimationController: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect

    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        toView.frame = self.originFrame
        toView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        toView.layer.cornerRadius = 20
        toView.layer.masksToBounds = true
        toView.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseOut) {
            toView.transform = .identity
            toView.alpha = 1
        } completion: { _ in
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            UIView.animate(withDuration: 0.5) {
                containerView.layoutIfNeeded()
            }
        }
        transitionContext.completeTransition(true)
    }
}
