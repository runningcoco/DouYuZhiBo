//
//  PageTitleView.swift
//  DouYuZhiBo
//
//  Created by echochief on 16/10/3.
//  Copyright © 2016年 echochief. All rights reserved.
//

import UIKit

protocol  PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    // 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 设置UI界面
extension PageTitleView {
    fileprivate func setupUI() {
        
        // 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加title对应的label
        setupTitleLabels()
        
        // 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
    
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
    
        for (index, title) in titles.enumerated() {
            // 创建label
            let label = UILabel()
            
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.tag = index
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
		
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //  给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
}
    
    private func setupBottomLineAndScrollLine() {
        // 创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
		
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
		
        // 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}


// MARK:- label的点击
extension PageTitleView  {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        // 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
		
        // 获取之前的label
        let oldLabel = titleLabels[currentIndex]
		
        // 切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        // 保存最新label的下标值
        currentIndex = currentLabel.tag
        
        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
		
        // 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}













