//
//  ColorsCVC.swift
//  ShoppingApp
//
//  Created by Aniket Patil on 17/01/23.
//

import UIKit
import EMTNeumorphicView

class ColorsCVC: UICollectionViewCell {

    @IBOutlet weak var colorView: EMTNeumorphicView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNeumorphicEffect()
    }
    private func setNeumorphicEffect(){
        colorView.neumorphicLayer?.elementBackgroundColor = colorView.backgroundColor?.cgColor ?? #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        colorView.neumorphicLayer?.cornerRadius = 15
        colorView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        colorView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        colorView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        colorView.neumorphicLayer?.shadowRadius = 6
        colorView.neumorphicLayer?.cornerType = .all
        colorView.neumorphicLayer?.darkShadowOpacity = 0.3
        colorView.neumorphicLayer?.shadowOpacity = 1
        colorView.neumorphicLayer?.depthType = .convex
    }
}
