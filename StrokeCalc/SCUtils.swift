//
//  SCUtils.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/21/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCUtils: NSObject {
    
    static let shared: SCUtils = {
        let instance = SCUtils()
        return instance
    }()
    
    func sizeFor(value: CGFloat) -> CGFloat {
        return ScreenSize.SCREEN_HEIGHT * value / 667.0
    }
    
    func showEndExamAlert() {
        let alertC = UIAlertController(title: "", message: "End exam", preferredStyle: UIAlertControllerStyle.alert)
        let okA = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            
        }
        alertC.addAction(okA)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertC, animated: true, completion: nil)
    }
    
    struct ComponentSize {
        static let BUTTON_HEIGHT = ScreenSize.SCREEN_HEIGHT * 65 / 667.0
        static let LABEL_FONT15 = ScreenSize.SCREEN_HEIGHT * 15 / 667.0
        static let LABEL_FONT17 = ScreenSize.SCREEN_HEIGHT * 17 / 667.0
        static let LABEL_FONT23 = ScreenSize.SCREEN_HEIGHT * 23 / 667.0
        
        static let SIZE_90 = ScreenSize.SCREEN_HEIGHT * 90 / 667.0
        static let SIZE_140 = ScreenSize.SCREEN_HEIGHT * 140 / 667.0
        static let SIZE_200 = ScreenSize.SCREEN_HEIGHT * 200 / 667.0
        static let SIZE_220 = ScreenSize.SCREEN_HEIGHT * 220 / 667.0
        static let SIZE_260 = ScreenSize.SCREEN_HEIGHT * 260 / 667.0
        static let SIZE_300 = ScreenSize.SCREEN_HEIGHT * 300 / 667.0
        static let SIZE_330 = ScreenSize.SCREEN_HEIGHT * 330 / 667.0
        static let SIZE_375 = ScreenSize.SCREEN_HEIGHT * 375 / 667.0
        static let SIZE_405 = ScreenSize.SCREEN_HEIGHT * 405 / 667.0
        static let SIZE_450 = ScreenSize.SCREEN_HEIGHT * 450 / 667.0
        static let SIZE_600 = ScreenSize.SCREEN_HEIGHT * 600 / 667.0
        static let SIZE_640 = ScreenSize.SCREEN_HEIGHT * 640 / 667.0
        static let SIZE_880 = ScreenSize.SCREEN_HEIGHT * 880 / 667.0
    }
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }

    
}

extension String {
    func isEmail() -> Bool {
        
        let regex = try! NSRegularExpression(pattern: "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$",options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isName() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z]{2,60}$",options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isSchool() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z]{3,60}$",options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options:[],range: NSMakeRange(0, utf16.count)) != nil
    }
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, transperancy: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: transperancy)
    }
    
     class var prnDark: UIColor {
        let darkTextColor = UIColor().hexStringToUIColor(hex: "#4A4A4A")
        return darkTextColor
    }
    
    class var prnGray : UIColor {
        let newRed = CGFloat(249)/255
        let newGreen = CGFloat(249)/255
        let newBlue = CGFloat(249)/255
        
        let color = UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        return color
    }
    
    class var prnOrange : UIColor {
        let newRed = CGFloat(237)/255
        let newGreen = CGFloat(137)/255
        let newBlue = CGFloat(47)/255
        
        let darkTextColor = UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        return darkTextColor
    }
    
    class var prnRed : UIColor {
        let newRed = CGFloat(177)/255
        let newGreen = CGFloat(0)/255
        let newBlue = CGFloat(28)/255
        
        let darkTextColor = UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        return darkTextColor
    }
    
    class var prnBlue : UIColor {
        let newRed = CGFloat(27)/255
        let newGreen = CGFloat(137)/255
        let newBlue = CGFloat(205)/255
        
        let prnBlueColor = UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        return prnBlueColor
    }
    
    class var prnCellHighlightedColor : UIColor {
        let prnHighlightedColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        return prnHighlightedColor
    }
    
    class var prnCellNormalColor : UIColor {
        let prnNormalColor = UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0)
        return prnNormalColor
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension NSMutableAttributedString {
    
    //Attaching image
    func imageWith(name: String) -> NSMutableAttributedString {
        
        let attachImage = NSTextAttachment()
        attachImage.image = UIImage(named: name)
        let attrStr = NSAttributedString(attachment: attachImage)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attrs:[String:AnyObject] = [NSParagraphStyleAttributeName:paragraphStyle]
        
        let mutableStr = NSMutableAttributedString(attributedString: attrStr)
        mutableStr.addAttributes(attrs, range: NSMakeRange(0, mutableStr.length))
        
        self.append(mutableStr)
        return self
    }
    
    //SFUIDisplay-Medium
    func button(text:String, size:CGFloat, color:UIColor) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.alignment = NSTextAlignment.center
        //        paragraphStyle.lineSpacing = 11.0
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    //SFUIDisplay-Medium
    func blueButton(text:String, size:CGFloat) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.alignment = NSTextAlignment.center
//        paragraphStyle.lineSpacing = 11.0
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func bold(text:String) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func bold(text:String, size:CGFloat, align:NSTextAlignment) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        paragraphStyle.alignment = align
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func bold(text:String, space:CGFloat) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: space)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func boldItalic(text:String) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-BoldItalic", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func boldBlue(text:String) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func boldBlue(text:String, size:CGFloat) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func boldBlue(text:String, size:CGFloat, align:NSTextAlignment) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.alignment = align
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func mediumBlue(text:String, size:CGFloat, align:NSTextAlignment) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        paragraphStyle.alignment = align
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func boldRed(text:String, size: CGFloat, align: NSTextAlignment) -> NSMutableAttributedString {
        
        let font = UIFont(name: "GothamHTF-Bold", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        paragraphStyle.alignment = align
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnRed, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func blueBoldItalic(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-BoldItalic", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func orangeBoldItalic(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-BoldItalic", size: SCUtils.shared.sizeFor(value: 15))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnOrange, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func normal(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    //SFUIDisplay-Regular
    func textForCell(text:String, size:CGFloat, alignment:NSTextAlignment)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
//        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        paragraphStyle.alignment = alignment
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func normalItalic(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-BookItalic", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnDark, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }

    func normalBlue(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func normalBlue(text:String, size:CGFloat)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: size))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func normalBlue(text:String, alignment:NSTextAlignment)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        paragraphStyle.alignment = NSTextAlignment.center
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }

    func underlinedNormal(text:String)->NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Book", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.darkText, NSParagraphStyleAttributeName:paragraphStyle,NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue as AnyObject]
        let normal = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(normal)
        return self
    }
    
    func boldHeader(text:String) -> NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: 23))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 19.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 10.0)
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func bold23(text:String, alignment:NSTextAlignment) -> NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: 23))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 19.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 10.0)
        paragraphStyle.alignment = alignment
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnBlue, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func orangeBold(text:String) -> NSMutableAttributedString {
        let font = UIFont(name: "GothamHTF-Medium", size: SCUtils.shared.sizeFor(value: 17))!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 14.0
        paragraphStyle.lineSpacing = SCUtils.shared.sizeFor(value: 8.0)
        
        let attrs:[String:AnyObject] = [NSFontAttributeName : font,NSForegroundColorAttributeName : UIColor.prnOrange, NSParagraphStyleAttributeName:paragraphStyle]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }

}

extension UINavigationController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override open var shouldAutorotate: Bool {
        return true
    }
}
