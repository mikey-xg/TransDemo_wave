//
//  sliderView.swift
//  transDemo
//
//  Created by best su on 2018/8/13.
//  Copyright © 2018年 best su. All rights reserved.
//

import UIKit
import SnapKit


let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

class sliderView: UIView {
    
    ///  记录 连个帮助view的间隔差值
    var diff: CGFloat = 0
    var displayLink: CADisplayLink?
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.frame = CGRect.init(x: -(screenWidth/2 + 50), y: 0, width: screenWidth/2 + 50, height: screenHeight)
        self.backgroundColor = UIColor.clear
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchAcition(_ isSelect: Bool? = nil){
        if isSelect == false{
            UIView.animate(withDuration: 0.3) {
                self.frame = self.bounds
            }
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                self.helperView.center = CGPoint(x: screenWidth/2, y: 20)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                self.helperCenterView.center = CGPoint(x: screenWidth/2, y:screenHeight/2 + 20)
            }) { (_) in
                self.removeDisplayLink()
            }
//            获取差值
            setDisplayLink()
        }else{
            UIView.animate(withDuration: 0.5) {
                self.frame = CGRect.init(x: -(screenWidth/2 + 50), y: 0, width: screenWidth/2 + 50, height: screenHeight)
            }
            self.helperView.frame = CGRect(x: -40, y: 0, width: 40, height: 40)
            self.helperCenterView.frame = CGRect(x: -40, y: screenHeight/2 - 20, width: 40, height: 40)
        }
    }
    
    private func setUI(){
        addSubview(helperView)
        addSubview(helperCenterView)
        self.helperView.frame = CGRect(x: -40, y: 0, width: 40, height: 40)
        self.helperCenterView.frame = CGRect(x: -40, y: screenHeight/2 - 20, width: 40, height: 40)
    }
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: screenWidth/2, y: 0))
        path.addQuadCurve(to: CGPoint(x: screenWidth/2, y: screenHeight), controlPoint: CGPoint(x: screenWidth/2 + diff, y: screenHeight/2))
        path.addLine(to: CGPoint(x: 0, y: screenHeight))
        path.close()
        
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path.cgPath)
        UIColor.red.set()
        context?.fillPath()
    }

    /// 添加  CADisplayLink
    private func setDisplayLink(){
        if (displayLink == nil) {
            displayLink = CADisplayLink.init(target: self, selector: #selector(displayLinkClink(link:)))
            displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    /// 移除  CADisplayLink
    private func removeDisplayLink(){
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func displayLinkClink(link: CADisplayLink){
        let helpViewLayer = self.helperView.layer.presentation()
        let helpCenterViewLayer = self.helperCenterView.layer.presentation()
        
        let r1:CGRect = helpViewLayer?.value(forKeyPath: "frame") as! CGRect
        let r2:CGRect = helpCenterViewLayer?.value(forKeyPath: "frame") as! CGRect
        self.diff = r1.origin.x - r2.origin.x
//        print(diff)
        self.setNeedsDisplay()
    }

    //    MARK: - 控件加载
    
    private lazy var helperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var helperCenterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
}
