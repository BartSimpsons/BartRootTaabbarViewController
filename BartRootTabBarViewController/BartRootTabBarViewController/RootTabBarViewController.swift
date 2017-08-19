//
//  RootTabBarViewController.swift
//  unionMerchant
//
//  Created by simpsons on 2017/8/16.
//  Copyright © 2017年 simpsons. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController, RootTabBarDelegate{

    let tabBarNormalImages = ["TabBar0_Normal","TabBar0_Normal","TabBar0_Normal","TabBar0_Normal"]
    let tabBarSelectedImages = ["TabBar0_Selected","TabBar0_Selected","TabBar0_Selected","TabBar0_Selected"]
    let tabBarTitles = ["首页","消息","功能","我的"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor.colorWithHexString("f3f3f5")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = RootTabBar()
        tab.addDelegate = self
        self.setValue(tab, forKey: "tabBar")
        self.setRootTabbarConntroller()
        // Do any additional setup after loading the view.
    }
    
    /// 上传按钮执行方法
    func addClick() {
        
        print("add succeed")
    }
    
    func setRootTabbarConntroller(){
        
        var vc : UIViewController?
        
        for i in 0..<self.tabBarNormalImages.count {
            
            //创建根控制器
            switch i {
            case 0:
                vc = ViewController()
            case 1:
                vc = UIViewController()
            case 2:
                vc = UIViewController()
            case 3:
                vc = UIViewController()
            default:
                break
            }
            
            //创建导航控制器
            let nav = RootNavigationController.init(rootViewController: vc!)
            
            //1.创建tabbarItem
            let barItem = UITabBarItem.init(title: self.tabBarTitles[i], image: UIImage.init(named: self.tabBarNormalImages[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: self.tabBarSelectedImages[i])?.withRenderingMode(.alwaysOriginal))
            
            //2.更改字体颜色
            barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithHexString("cccccc")], for: .normal)
            barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithHexString("21d1c1")], for: .selected)
            
            //设置标题
            vc?.title = self.tabBarTitles[i]
            
            //设置根控制器
            vc?.tabBarItem = barItem
            
            //添加到当前控制器
            self.addChildViewController(nav)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

/// 上传按钮点击代理
protocol RootTabBarDelegate:NSObjectProtocol {
    func addClick()
}

/// 自定义tabbar，修改UITabBarButton的位置
class RootTabBar: UITabBar {
    
    weak var addDelegate: RootTabBarDelegate?
    
    private lazy var addButton:UIButton = {
        return UIButton()
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addButton.setBackgroundImage(UIImage.init(named: "Icon_add"), for: .normal)
        addButton.addTarget(self, action: #selector(RootTabBar.addButtonClick), for: .touchUpInside)
        self.addSubview(addButton)
        /// tabbar设置背景色
//        self.shadowImage = UIImage()
        self.backgroundImage = UIColor.creatImageWithColor(color: UIColor.white)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButtonClick(){
        if addDelegate != nil{
            addDelegate?.addClick()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let buttonX = self.frame.size.width/5
        var index = 0
        for barButton in self.subviews{
            
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
                
                if index == 2{
                    /// 设置添加按钮位置
                    addButton.frame.size = CGSize.init(width: (addButton.currentBackgroundImage?.size.width)!, height: (addButton.currentBackgroundImage?.size.height)!)
                    addButton.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2 - 18)
                    index += 1
                }
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height)
                index += 1
                
            }
        }
        self.bringSubview(toFront: addButton)
    }
    
    /// 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.addButton)
            /// 判断新的点是否在按钮上
            if self.addButton.point(inside: onButton, with: event){
                return addButton
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
}

/// 导航栏设置
class RootNavigationController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultSetting()
    }
    
    func defaultSetting(){
        
        //导航栏的背景色与标题设置
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.colorWithRGB(r:51/255, g: 51/255, b: 51/255, alpha: 1),NSFontAttributeName:UIFont.systemFont(ofSize:17)]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0{
            viewController.tabBarController?.tabBar.isHidden=true
            
            //导航栏返回按钮自定义
            let backButton = UIButton(frame:CGRect.init(x:15, y: 2, width: 30, height: 40))
            backButton.imageEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
            backButton.setImage(UIImage.init(named:"Icon_back"), for: UIControlState.normal)
            backButton.addTarget(self, action:#selector(self.didBackButton(sender:)), for: UIControlEvents.touchUpInside)
            backButton.sizeToFit()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:backButton)
        }
        super.pushViewController(viewController, animated: true)
    }
    
    //点击事件
    func didBackButton(sender:UIButton){
        self.popViewController(animated:true)
    }
}


