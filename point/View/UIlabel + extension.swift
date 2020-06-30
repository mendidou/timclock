//
//  UIlabel + extension.swift
//  point
//
//  Created by mendy aouizerat  on 23/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
//


import UIKit

extension UILabel{
    
    // build a label from code and add it automaticely to view
    func labelFromCode ( text : String , frame : CGRect , textColor :UIColor , positionCenter : CGPoint , textAlignement : NSTextAlignment , View :UIView) -> UILabel {
        self.text = text
        self.frame = frame
        self.textColor = textColor
        self.center = positionCenter
        self.textAlignment = textAlignement
        self.numberOfLines = 1
        self.font = .boldSystemFont(ofSize: 32)
        View.addSubview(self)
    
        return self
    }
}
