//
//  ViewController.swift
//  MemeTest
//
//  Created by xXxXx on 12/04/2019.
//  Copyright © 2019 abdullah. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextFieldDelegate{
    // Meme text and image
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var shareButton : UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topBar: UINavigationItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var meme : [Meme]?
   
     func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode =  .scaleAspectFit
            imagePickerView.image = image
        }
        
      dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // code
        dismiss(animated: true, completion: nil)
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -2 ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Your Code Here...
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
       subscribeToKeyboardNotifications()
        top.text = "TOP"
        bottom.text = "BOTTOM"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
 
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if bottom.isFirstResponder{
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.delegate = self
        textField.textAlignment = .center
        textField.textAlignment = .center
        textField.textColor = .white
        textField.textColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        
        navigationItem.largeTitleDisplayMode = .never
        prepareTextField(textField: top, defaultText:"TOP")
        prepareTextField(textField: bottom, defaultText:"BOTTOM")
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
 
    func pickImage(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(sourceType:.photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(sourceType:.camera)
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField){
        
         textField.text = " "
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    
    private func save(_ memeImage: UIImage) {
        
        print(memeImage)
        
        if imagePickerView.image == nil
        {
            print("error")
        }else
        {
            // Create the meme
            let meme = Meme(topText: top.text ?? "", bottomText: bottom.text ?? "", originalImage: imagePickerView.image!, memedImage:  generateMemedImage())
            // Add it to the memes array in the Application Delegate
            
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        }
        
    }
    
    @IBAction private func share(_ sender: Any) {
        let memeImage = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activity.completionWithItemsHandler = {_, completed, _, _ in
            if completed {
            self.save(memeImage)
            self.dismiss(animated: true, completion: nil)
        }
        }
        present(activity, animated: true, completion: nil)
        
    }
    
    func generateMemedImage() -> UIImage {
       
         //TODO: Hide toolbar and navbar
        toolBar.isHidden = true
    
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
           // TODO: Show toolbar and navbar
        toolBar.isHidden = false
        return memedImage
    }
}

