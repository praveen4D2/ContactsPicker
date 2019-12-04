//
//  ProtocolOrientedProgramming.swift
//  ContactsPicker
//
//  Created by Adaps on 04/12/19.
//  Copyright © 2019 CrazyTricks. All rights reserved.
//

import Foundation
import UIKit

protocol CircularCornerRadius{}

//MARK : Cornered As Circle
extension CircularCornerRadius where Self: UIView {
    func setCircularCornerRadius(getView : UIView)
    {
        self.layer.cornerRadius = getView.frame.size.height / 2
        self.clipsToBounds = true
    }
}


//Mark : AllSidesShadow
protocol TopShadow{}
extension TopShadow where Self: UIView {
    func setTopShadow(view : UIView)
    {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: -1)
        
    }
}


class CustomizedView: UIView,CircularCornerRadius, TopShadow{
}

class CustomizedBtn: UIButton,CircularCornerRadius,TopShadow{
}
