//
//  UIColor+ext.swift
//  NetflixClone
//
//  Created by Alisher Djuraev on 08/07/22.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0 )
    }
}
