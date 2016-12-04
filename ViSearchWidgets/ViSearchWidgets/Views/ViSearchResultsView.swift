//
//  ViSearchResultsView.swift
//  ViSearchWidgets
//
//  Created by Hung on 23/11/16.
//  Copyright © 2016 Visenze. All rights reserved.
//

import UIKit

/// present search results in either horizontal scrollview or vertical grid
/// The layout is vertical and as follow: headerView - collectionView - footerView
/// headerView generally contains the widget title such as "You May Also Like"
/// footerView generally contains the Power by Visenze image
open class ViSearchResultsView: UIView {
    
    // left padding for this view
    public var paddingLeft: CGFloat = 0.0
    
    /// right padding for this view
    public var paddingRight: CGFloat = 0.0
    
    /// collection view layout for search results
    public var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    /// container for header
    public var headerViewContainer: UIView = UIView()
    
    /// collection view to contain results
    public var collectionView: UICollectionView?
    
    /// container for footer
    public var footerViewContainer: UIView = UIView()
    
    /// header height. Set to 0 to hide the header
    public var headerHeight : CGFloat = 0
    
    /// Footer view. Set to 0 to hide
    public var footerHeight : CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        self.autoresizingMask = [.flexibleHeight , .flexibleWidth];
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout  )
        self.addSubview(self.collectionView!)
        
        self.addSubview(self.headerViewContainer)
        self.addSubview(self.footerViewContainer)
        
    }
    
    /// layout views vertically: header, collectionview, footer
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // view has not been init
        if(self.bounds.height == 0)
        {
            self.headerViewContainer.frame = .zero
            self.collectionView?.frame = .zero
            self.footerViewContainer.frame = .zero
            return
        }
        
        let headerViewHeight = max(headerHeight, 0)
        let footerViewHeight = max(footerHeight , 0)
        
        self.headerViewContainer.frame = CGRect(x: self.paddingLeft, y: 0,
                                        width: self.bounds.size.width - self.paddingLeft - self.paddingRight,
                                        height: headerViewHeight  )
        
        self.collectionView?.frame = CGRect(x: self.paddingLeft,
                                            y: self.headerViewContainer.frame.origin.y + headerViewHeight,
                                            width: self.bounds.size.width - self.paddingLeft - self.paddingRight,
                                            height: self.bounds.size.height - headerViewHeight - footerViewHeight
        )

        self.footerViewContainer.frame = CGRect(x: self.paddingLeft,
                                                y: self.collectionView!.frame.origin.y + self.collectionView!.frame.size.height ,
                                                width: self.bounds.size.width - self.paddingLeft - self.paddingRight,
                                                height: footerViewHeight)
        
        
    }
    
    /// Remove all subviews in headerViewContainer and put the new headerView inside
    ///
    /// - Parameter headerView: new headerView
    public func setHeader(_ headerView: UIView) {
        for view in self.headerViewContainer.subviews{
            view.removeFromSuperview()
        }
        
        self.headerViewContainer.addSubview(headerView)
    }
    
    /// Remove all subviews in footerViewContainer and put the new footerView inside
    ///
    /// - Parameter footerView: new footerView
    public func setFooter(_ footerView: UIView) {
        for view in self.footerViewContainer.subviews{
            view.removeFromSuperview()
        }
        
        self.footerViewContainer.addSubview(footerView)
    }


}
