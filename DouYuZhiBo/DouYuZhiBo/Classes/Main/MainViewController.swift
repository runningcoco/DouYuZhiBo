//
//  MainViewController.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/3.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyBoardName: "Home")
        addChildVc(storyBoardName: "Live")
        addChildVc(storyBoardName: "Follow")
        addChildVc(storyBoardName: "Profile")
    }
    
    private func addChildVc(storyBoardName : String){
        
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }

}
