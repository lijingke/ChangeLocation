//
//  ViewController.swift
//  ChangeLocation
//
//  Created by 李京珂 on 2023/1/31.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    
    private let textList: [String] = ["李於柯又在偷偷修改定位来打卡了！", "这种可耻的行为,我们要坚决反对!", "反对！"]
    
    fileprivate var containerView = UIView(frame: CGRect(x: 50, y: 200, width: UIScreen.main.bounds.width - 100, height: 30))
    fileprivate lazy var marqueeView = MNMarqueeView(frame: CGRect(x: 50, y: 200, width: UIScreen.main.bounds.width - 100, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        CommonUtil.showTextHUD(view: self.view, text: "李於柯童鞋\n恭喜你修改定位成功！")
        
        marqueeView.backgroundColor = .yellow
        view.addSubview(containerView)
        view.addSubview(marqueeView)
        marqueeView.textList = textList

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        marqueeView.run()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        marqueeView.stop()
    }


}

