//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/3.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        designUI()
    }
    
}

// MARK:  design UI
extension HomeViewController {
    fileprivate func designUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightImageName: "Image_scan_click", size: size)
		
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
