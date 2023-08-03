///
/// Loading
/// Protocol for loading manager
/// Final class for loading
///
/// - Author: Eslam Ali
/// - Date: 3/4/18
///

import UIKit
import Lottie

protocol LoadingDelegate {
    func show()
    func dismiss()
}

final class Loading: LoadingDelegate {
    
    static let manger = Loading()
    
    private init(){}
    
    private var overlayView: UIView!
    private var animationView: AnimationView?
    
    
   internal func dismiss(){
        DispatchQueue.main.async{ [weak self] in
            guard let strongSelf = self else{return}
            guard let strongAnimationView = strongSelf.animationView else{return}
            strongAnimationView.stop()
            strongAnimationView.removeFromSuperview()
            guard let strongOverlayView = strongSelf.overlayView else{return}
            strongOverlayView.removeFromSuperview()
        }
    }
 
   
    internal func show(){
        dismiss()
        DispatchQueue.main.async{ [weak self] in
            guard let strongSelf = self else{return}
            guard let currentVC = Helper.shared.getCurrentViewController() else {return}
            //var strongOverlayView = strongSelf.overlayView!
            //var strongAnimationView = strongSelf.animationView!
            strongSelf.overlayView = UIView(frame: UIScreen.main.bounds)
            strongSelf.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            currentVC.view.addSubview( strongSelf.overlayView)
            strongSelf.animationView = .init(name: "Loading")
            strongSelf.animationView?.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
            strongSelf.animationView?.center =  strongSelf.overlayView.center
            strongSelf.animationView?.contentMode = .scaleAspectFit
            strongSelf.animationView?.loopMode = .loop
            strongSelf.animationView?.animationSpeed = 1
            strongSelf.overlayView.addSubview(strongSelf.animationView!)
            strongSelf.animationView?.play()
        }
    }
}




