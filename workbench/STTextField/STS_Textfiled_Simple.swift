//
//  File.swift
//  workbench
//
//  Created by admin on 4/08/2016.
//  Copyright © 2016 stethee.com. All rights reserved.
//

import UIKit
//@IBDesignable public class STTextFiled:UITextField{
@IBDesignable public class STS_Textfiled_Simple:UITextField{
    
    var TitleLabel:UILabel! //= UILabel()
    var ErrorLabel:UILabel! //= UILabel()
    var paddings = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 10)
    var didLayout = false
    var hostStack : UIStackView!
    @IBInspectable var TitleString:String!{
        didSet{
            TitleLabel.text = TitleString
            
        }
        
    }
    @IBInspectable var ErrorString:String!{
        didSet{
            ErrorLabel.text = ErrorString
        }
        
    }
    
    
    
    
    @IBInspectable var TitleFontSize:CGFloat = 13{
        didSet{
            let font = TitleLabel.font
            TitleLabel.font = UIFont(name: (font?.fontName)!, size: TitleFontSize)
        }
    }
    
    
    @IBInspectable var ErrorFontSize:CGFloat = 11{
        didSet{
            let font = ErrorLabel.font
            ErrorLabel.font = UIFont(name: (font?.fontName)!, size: ErrorFontSize)
        }
    }
    
    
    
    
    @IBInspectable var TitleColor:UIColor = UIColor.darkGrayColor(){
        didSet{
            TitleLabel.textColor = TitleColor
        }
    }
    
    
    @IBInspectable var ErrorColor:UIColor = UIColor.darkGrayColor(){
        didSet{
            ErrorLabel.textColor = ErrorColor
        }
    }

    
    
    @IBInspectable var leftIcon:UIImage!{
        didSet{
            
            paddings = UIEdgeInsets(top: 10, left:frame.height, bottom: 5, right: 10)
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
            let instack = (superview?.isKindOfClass(UIStackView.self))
            
            if( instack! ){
                hostStack = superview as! UIStackView
                hostStack.spacing = 25
                hostStack.setNeedsDisplay()
            }
        }
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if(!didLayout){
            didLayout = true
        }
    }
    private func setup(){

        //set up\
        TitleLabel = UILabel()
        ErrorLabel = UILabel()
        
        self.borderStyle = UITextBorderStyle.None
        self.layer.cornerRadius = 5
        self.clipsToBounds = false
        self.backgroundColor = UIColor.clearColor()
        self.frame.height
        
        TitleLabel = UILabel(frame: CGRect(x: 0,y: -12,width: frame.width,height: 20))
        ErrorLabel = UILabel(frame: CGRect(x: 0,y: 30,width: frame.width,height: 13) )
        TitleLabel.clipsToBounds = false
        ErrorLabel.clipsToBounds = false
        TitleLabel.font = UIFont(name: (font?.fontName)!, size: TitleFontSize)
        ErrorLabel.font = UIFont(name: (font?.fontName)!, size: ErrorFontSize)
        ErrorLabel.textColor = ErrorColor
        TitleLabel.textColor = TitleColor
        
        self.addSubview(TitleLabel)
        self.addSubview(ErrorLabel)
        ErrorLabel.hidden = true
    }
    
    
    public func showError(){
        UIView.animateWithDuration(0.7) {

            self.resizeStack(40)
            self.ErrorLabel.hidden = false
        }
    }
    
    public func hideError(){
        
        UIView.animateWithDuration(0.7) {
            self.ErrorLabel.hidden = true
            self.resizeStack(25)
            
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

/*
extension UIViewController{

    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    
    
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.scrollEnabled = true
        var info : NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        var contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeFieldPresent = activeField
        {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
        
        
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        var info : NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        var contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField!)
    {
        activeField = nil
    }

}
*/