//
//  UIcolor + extension.swift
//  point
//
//  Created by mendy aouizerat  on 23/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
//


import UIKit

extension UIColor{
    //some usefull colors for the  project
    static func rgb(r:CGFloat,g:CGFloat,b:CGFloat , alpha : CGFloat = 1)->UIColor{
        return UIColor(red : r/255 , green: g/255 , blue: b/255,alpha: alpha)
    }
    static let outlineStrokeColor = UIColor.rgb(r:234 , g:46, b:111 )
    static let trakStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let  pulsatingFillColor = UIColor.rgb(r: 140, g: 30, b: 63, alpha: 0.3)
    static let loginColorForpulsatin = UIColor.rgb(r: 56, g: 100, b: 30, alpha: 0.3)
    
}
