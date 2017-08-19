//
//  Color_extension.swift
//  unionMerchant
//
//  Created by simpsons on 2017/8/15.
//  Copyright © 2017年 simpsons. All rights reserved.
//

import UIKit

extension UIColor
{
    
    open class var hex_8D9199: UIColor { return UIColor.colorWithHexString("8D9199") }
    
    open class var hex_3A3A3A: UIColor { return UIColor.colorWithHexString("3A3A3A") }
    
    open class var hex_3D3D3D: UIColor { return UIColor.colorWithHexString("3D3D3D") }
    
    open class var hex_3C3C3C: UIColor { return UIColor.colorWithHexString("3C3C3C") }
    
    open class var hex_303030: UIColor { return UIColor.colorWithHexString("303030") }
    
    open class var hex_262626: UIColor { return UIColor.colorWithHexString("262626") }
    
    open class var hex_45CA87: UIColor { return UIColor.colorWithHexString("45CA87") }
    
    open class var hex_FF7733: UIColor { return UIColor.colorWithHexString("FF7733") }
    
    open class var hex_F2F3F5: UIColor { return UIColor.colorWithHexString("F2F3F5") }
    
    open class var hex_FBFBFB: UIColor { return UIColor.colorWithHexString("FBFBFB") }
    
    open class var hex_010101: UIColor { return UIColor.colorWithHexString("010101") }
    
    open class var hex_888888: UIColor { return UIColor.colorWithHexString("888888") }
    
    open class var hex_C2C2C2: UIColor { return UIColor.colorWithHexString("C2C2C2") }
    
    open class var hex_C7C7CD: UIColor { return UIColor.colorWithHexString("C7C7CD") }
    
    open class var hex_3BA7F5: UIColor { return UIColor.colorWithHexString("3BA7F5") }
    
    open class var hex_DEDEDE: UIColor { return UIColor.colorWithHexString("DEDEDE") }
    
    open class var hex_B7B7B7: UIColor { return UIColor.colorWithHexString("B7B7B7") }
    
    open class var hex_A8A8A8: UIColor { return UIColor.colorWithHexString("A8A8A8") }
    
    open class var hex_A7A8AB: UIColor { return UIColor.colorWithHexString("A7A8AB") }
    
    open class var hex_449ffb: UIColor { return UIColor.colorWithHexString("449ffb") }
    
    open class var BGCloro_Normal: UIColor { return UIColor.colorWithHexString("f3f3f5") }
    
    open class var BGCloro_ButtonAct: UIColor { return UIColor.colorWithHexString("21d1c1") }
    
    open class var BGCloro_ButtonNoAct: UIColor { return UIColor.colorWithHexString("c1f5f1") }
    /**
     快速构建rgb颜色
     
     - parameter r: r
     - parameter g: g
     - parameter b: b
     
     - returns: 返回rgb颜色对象，alpha默认1
     */
    class func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha:CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    /**
     生成随机颜色
     
     - returns: 返回随机色
     */
    class func randomColor() -> UIColor
    {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r: r, g: g, b: b, alpha: 1)
    }
    
    /**
     16进制转UIColor
     
     - parameter hex: 16进制
     
     - returns: UIColor
     */
    class func colorWithHexString(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /// UIColor转UIImage
    class func creatImageWithColor(color:UIColor) -> UIImage{
        
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
    
}
