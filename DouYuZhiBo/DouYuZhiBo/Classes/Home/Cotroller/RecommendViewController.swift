//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/5.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH : CGFloat = kScreenW * 3 / 8

private let kHeaderViewID = "kHeaderViewID"
private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {
    
    // 数据模型
    fileprivate lazy var recommandVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    fileprivate lazy var cycleView : RecommandCycleView = {[unowned self] in
        let cycleView = RecommandCycleView.recommandCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
		
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // 设置UI
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}

// 设置UI界面
extension RecommendViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        
        // 将cycleView加入collectionView
        collectionView.addSubview(cycleView)
        
        // 设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 发送网络请求
extension RecommendViewController {
    fileprivate func loadData() {
        recommandVM.requestData {
            self.collectionView.reloadData()
        }
    }
}



// MARK:- UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandVM.anchorGroups.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommandVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            // 取出模型对象
            let group = recommandVM.anchorGroups[(indexPath as NSIndexPath).section]
            let anchor = group.anchors[(indexPath as NSIndexPath).item]
		
            // 定义cell
            let cell : CollectionBaseCell!
		
            // 取出cell
            if (indexPath as NSIndexPath).section == 1 {
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            }  else {
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            }
        
            cell.anchor = anchor
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            // 取出section中的HeaderView
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
            headerView.group = recommandVM.anchorGroups[(indexPath as NSIndexPath).section]
        
            return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if (indexPath as NSIndexPath).section == 1 {
                return CGSize(width: kItemW, height: kPrettyItemH)
        }
            return CGSize(width: kItemW, height: kNormalItemH)
    }
  
}


















