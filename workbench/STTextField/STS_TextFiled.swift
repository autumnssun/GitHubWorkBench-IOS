//
//  File.swift
//  workbench
//
//  Created by admin on 4/08/2016.
//  Copyright © 2016 stethee.com. All rights reserved.
//

import UIKit
//@IBDesignable public class STTextFiled:UITextField{
@IBDesignable public class STS_TextFiled:UITextField{
    
    var TitileLabel:UILabel! //= UILabel()
    var ErrorLabel:UILabel! //= UILabel()
    var paddings = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 10)
    var didLayout = false
    var hostStack : UIStackView!
    @IBInspectable var TitleString:String!{
        didSet{
            TitileLabel.text = TitleString
            
        }
        
    }
    @IBInspectable var ErrorString:String!{
        didSet{
            ErrorLabel.text = ErrorString
        }
        
    }
    
    @IBInspectable var TitleFontSize:CGFloat = 13{
        didSet{
            let font = TitileLabel.font
            TitileLabel.font = UIFont(name: (font?.fontName)!, size: TitleFontSize)
        }
    }
    
    
    @IBInspectable var ErrorFontSize:CGFloat = 11{
        didSet{
            let font = ErrorLabel.font
            ErrorLabel.font = UIFont(name: (font?.fontName)!, size: ErrorFontSize)
        }
    }
    
    
    @IBInspectable var leftIcon:UIImage!{
        didSet{
            paddings = UIEdgeInsets(top: 14, left: CGFloat(frame.height + CGFloat(16)), bottom: 14, right: 14)
            self.leftViewMode = .Always
            let le_img =  UIImageView(frame: CGRect(x: 0, y: 0, width: frame.height+16, height: frame.height))
            le_img.image=leftIcon
            self.leftView = le_img
            le_img.contentMode = .ScaleAspectFit
            le_img.image = le_img.image!.imageWithRenderingMode(.AlwaysTemplate)
            le_img.tintColor=textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override public func didMoveToSuperview() {
        if(self.superview  != nil){
            print(superview)
            
            let instack = (superview?.isKindOfClass(UIStackView.self))
            
            if( instack! ){
                hostStack = superview as! UIStackView
            }
        }
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if(!didLayout){
            didLayout = true
            let snapFrame = self.bounds
            let maskLayer = CAShapeLayer()
            let circlePath = UIBezierPath(roundedRect: snapFrame, cornerRadius: 5)
            maskLayer.path = circlePath.CGPath
            maskLayer.fillColor = UIColor.darkTextColor().CGColor
            self.layer.insertSublayer(maskLayer, atIndex: 100)
            
        }
        
        
        
        
    }
    private func setup(){
        //set up\
        TitileLabel = UILabel()
        ErrorLabel = UILabel()
        
        self.borderStyle = UITextBorderStyle.None
        self.layer.cornerRadius = 5
        self.clipsToBounds = false
        self.backgroundColor = UIColor.clearColor()
        self.frame.height
        
        
        TitileLabel = UILabel(frame: CGRect(x: 0,y: -22,width: frame.width,height: 20))
        ErrorLabel = UILabel(frame: CGRect(x: 0,y: 44,width: frame.width,height: 20) )
        TitileLabel.clipsToBounds = false
        ErrorLabel.clipsToBounds = false
        TitileLabel.font = UIFont(name: (font?.fontName)!, size: TitleFontSize)
        ErrorLabel.font = UIFont(name: (font?.fontName)!, size: ErrorFontSize)
        
        self.addSubview(TitileLabel)
        self.addSubview(ErrorLabel)
        ErrorLabel.hidden = true
    }
    
    
    public func showError(){
        UIView.animateWithDuration(0.7) {
            
            self.resizeStack(22)
            self.ErrorLabel.hidden = false
        }
    }
    
    public func hideError(){
        UIView.animateWithDuration(0.7) {
            self.ErrorLabel.hidden = true
            self.resizeStack(8)
            
        }
    }
    
    private func resizeStack(sp:CGFloat){
        if(ErrorString != nil && hostStack != nil){
            hostStack.spacing = sp
            hostStack.setNeedsDisplay()
        }
    }
    
    
    public override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, paddings)
    }
    
    public override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, paddings)
    }
    
    public override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, paddings)
    }
    
    public func removeErrorMessage(){
        ErrorLabel.hidden = true
    }
    
    
    public func inject(label:UILabel){
        superview?.addSubview(label)
    }
    
    
}
