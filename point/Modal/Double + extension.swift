    //
    //  Double + extension.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //


    import Foundation
    extension Double {
        
       static var oneMinute:Double {
            return 60
        }
       static var oneSeconde:Double {
            return 1
        }
        
        func doubleToHoursMinutesSeconds () -> (Double, Double, Double) {
        let (hr,  minf) = modf ( self / 3600)
            let (min, secf) = modf (60 * minf)
            return (hr, min, 60 * secf)
        }
        
    }
