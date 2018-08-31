//
//  ViewController.swift
//  transDemo
//
//  Created by best su on 2018/8/13.
//  Copyright © 2018年 best su. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.layer.contents = UIImage.init(named: "222")?.cgImage
        
        view.addSubview(blurView)
        view.addSubview(demoView)
        view.addSubview(demoBtn)
        
        
        
        demoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.bottom.equalTo(-60)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
    
    var isSelect: Bool = false
    
    @objc private func demoBtnClick(){
        if isSelect == false{
            isSelect = true
            blurView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.5) {
                self.blurView.alpha = 1
            }
            demoView.switchAcition(false)
        }else{
            UIView.animate(withDuration: 0.5) {
                self.blurView.alpha = 0
            }
            demoView.switchAcition(true)
            isSelect = false
        }
    }
    


    
    private lazy var demoBtn: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.setTitle("点击按钮", for: .normal)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(demoBtnClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var demoView: sliderView = {
        let view = sliderView()
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        let view = UIVisualEffectView.init(effect: effect)
        view.alpha = 0
        return view
    }()
}

