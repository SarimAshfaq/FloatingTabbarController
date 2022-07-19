//
//  FloatingTabbarController.swift
//  Floating Tabbar Controller
//
//  Created by Sarim on 14/07/2022.
//

import UIKit

class FloatingTabbarController: UITabBarController {
    
    private var bgImageColor: UIColor = .black
    private let customTabbarLayer = CAShapeLayer()
    private var heightFactor: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 42:((tabBar.frame.height / 1.5) > 50 ? 50:(tabBar.frame.height / 1.5))
    }
    private var tabbarHeightFactor: CGFloat {
        return tabBar.frame.height / heightFactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChangeNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        tabBar.layer.insertSublayer(customTabbarLayer, at: 0)
        setupTabbar()
    }
    
    @objc func deviceOrientationDidChangeNotification(_ notification: Any) {
        setupTabbar()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.setupTabbar()
        }
    }
    
    private func setupTabbar() {
        customTabbarLayer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY, width: tabBar.bounds.width - 60, height: heightFactor), cornerRadius: 12).cgPath
        customTabbarLayer.shadowColor = UIColor.lightGray.cgColor
        customTabbarLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        customTabbarLayer.shadowRadius = 25.0
        customTabbarLayer.shadowOpacity = 0.3
        customTabbarLayer.borderWidth = 1.0
        customTabbarLayer.opacity = 1.0
        customTabbarLayer.isHidden = false
        customTabbarLayer.masksToBounds = false
        customTabbarLayer.fillColor = UIColor.white.cgColor
        
//        if let items = tabBar.items {
//            items.forEach { item in
//                item.imageInsets = UIEdgeInsets(top: -12, left: 0, bottom: 0, right: 0)
//            }
//        }
        
        tabBar.itemWidth = (tabBar.bounds.width - 60) / CGFloat(tabBar.items?.count ?? 1)
        tabBar.itemPositioning = .automatic
        setSelectedImage(CGSize(width: heightFactor, height: heightFactor * tabbarHeightFactor))
    }
    
    private func setSelectedImage(_ size: CGSize) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: size.height/tabbarHeightFactor))
        path.addQuadCurve(to: CGPoint(x: size.width/2, y: heightFactor/tabbarHeightFactor), controlPoint: CGPoint(x: size.width/2, y: size.height/tabbarHeightFactor))
        path.addQuadCurve(to: CGPoint(x: size.width, y: size.height/tabbarHeightFactor), controlPoint: CGPoint(x: size.width/2, y: size.height/tabbarHeightFactor))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = bgImageColor.cgColor
        shapeLayer.path = path.cgPath
        let renderer = UIGraphicsImageRenderer(size: size)
             
        let image = renderer.image {
            context in

            return shapeLayer.render(in: context.cgContext)
        }
        tabBar.selectionIndicatorImage = image
    }

}

@IBDesignable extension FloatingTabbarController {
    
    @IBInspectable var selectedTabbarItemBGImageColor: UIColor {
        set {
            bgImageColor = newValue
        }
        get {
            return bgImageColor
        }
    }
}
