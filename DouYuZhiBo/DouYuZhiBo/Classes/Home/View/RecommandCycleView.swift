//
//  RecommandCycle.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/8.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommandCycleView: UIView {
     // 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸拉伸
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
    }
}

extension RecommandCycleView {
    class func recommandCycleView() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}

extension RecommandCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
}
