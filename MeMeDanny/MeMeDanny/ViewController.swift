//
//  ViewController.swift
//  MeMeDanny
//
//  Created by Danny Nguyen on 7/10/16.
//  Copyright © 2016 Danny Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var navigationBarView: UINavigationBar!
    
    @IBOutlet weak var imageFolderView: UIBarButtonItem!

    @IBOutlet weak var cameraView: UIBarButtonItem!

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var bottomBarView: UIToolbar!
    
    @IBOutlet weak var shareButtonView: UIBarButtonItem!
    
    @IBOutlet weak var topTextView: UITextField!
    
    
    @IBOutlet weak var bottomTextView: UITextField!
    
    let textProperties = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.blueColor(),
        NSFontAttributeName : UIFont(name: "ArialHebrew-Bold", size: 24)!,
        NSStrokeWidthAttributeName : NSNumber(float: -3.0)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topTextView.delegate = self
        bottomTextView.delegate = self
       
        topTextView.text = "TOP TEXT"
        bottomTextView.text = "BOTTOM TEXT"
        topTextView.defaultTextAttributes = textProperties
        bottomTextView.defaultTextAttributes = textProperties
        

    }
    //function to generate meme from original immage
    func generateMemedImage() -> UIImage
    {
        navigationBarView.hidden = true
        bottomBarView.hidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationBarView.hidden = false
        bottomBarView.hidden = false
        
        return memedImage
    }
 
//function to save meme
    
    func save() {
        //Create the meme
        let memedImage = generateMemedImage()
        var newMeme = MemeStruct(topText: topTextView.text!, bottomText: bottomTextView.text!, originalImage:
            imagePickerView.image!, newMemeImage: memedImage)
    }
    
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                //Save the image
                self.save()
                //Dismiss the view controller
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraView.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    

        shareButtonView.enabled = imagePickerView.image != nil
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:" , name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    //shifts view in response to  UIKeyboardWillShowNotification
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y == 0
        
    }
    
    // Function to get keyboard height from notification's userinfo dictionary
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
   
    //function to pick image from folder library
    @IBAction func pickAnImage(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(controller, animated: true, completion: nil)
        
//        dismissViewControllerAnimated(true, completion: nil)
        
    }

    //Function that allows you to get image from camera
    @IBAction func pickAnImageFromCamera(sender: AnyObject){
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(controller, animated: true, completion: nil)
        
    }

    //Func to pass the selected image to the imagePickerView, this function is NEEDED or else it wont show in the current view
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    //function that lets u get out of the view
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
          dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

    //Function to write over original textfield in meme
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == topTextView && topTextView.text == "TOP TEXT") {
            topTextView.text = ""
        } else if (textField == bottomTextView && bottomTextView.text == "BOTTOM TEXT") {
            bottomTextView.text = ""
        }
    }
    
    //Function that allows use of return key to get out of text input
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

