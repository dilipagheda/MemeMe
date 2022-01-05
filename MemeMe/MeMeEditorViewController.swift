//
//  ViewController.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 28/12/21.
//

import UIKit

class MeMeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var albumButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIButton!
    
    let textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setTextFieldAttributes()
        
        self.topTextField.delegate = textFieldDelegate
        self.bottomTextField.delegate = textFieldDelegate
        
        toggleShareButtonEnableStatus()
        toggleCameraButtonEnableStatus()
        setTextFieldAttributes()
    }
    
    func toggleCameraButtonEnableStatus() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera) != true) {
            self.cameraButton.isEnabled = false
        }else{
            self.cameraButton.isEnabled = true
        }
    }

    func toggleAlbumButtonEnableStatus() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary) != true) {
            self.albumButton.isEnabled = false
        }else{
            self.albumButton.isEnabled = true
        }
    }

    func toggleShareButtonEnableStatus() {
        if(imageView.image != nil){
            shareButton.isEnabled = true
        }else{
            shareButton.isEnabled = false
        }
    }
    
    func setTextFieldDefaultText() {
        self.topTextField.text="TOP"
        self.bottomTextField.text="BOTTOM"
    }
    
    func setTextFieldAttributes() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth:  CGFloat(-5),
            .paragraphStyle: paragraphStyle
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onAlbumButtonTapHandler(_ sender: Any) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary) != true) {
            return
        }
        
        presentPickerViewController(source: .photoLibrary)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.originalImage]
        imageView.image = (img as! UIImage)
        toggleShareButtonEnableStatus()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onShareTapHandler(_ sender: Any) {
        
        let memedImage = self.generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error:Error?) in
                if completed {
                    self.saveMemedImage(memedImage)
                }
                self.dismiss(animated: true, completion: nil)
            }
        
        present(activityController, animated: true, completion: nil)
    }
    
    func saveMemedImage(_ memedImage: UIImage){
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        if let image = imageView.image {
            let meme = Meme(topText: topTextField?.text ?? "TOP", bottomText: bottomTextField?.text ?? "BOTTOM", memedImage: memedImage, originalImage: image)
            appDelegate.memes.append(meme)
        }
       
    }
   
    @IBAction func onCameraButtonTapHandler(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera) != true) {
            return
        }
        
        presentPickerViewController(source: .camera)
    }
    
    @IBAction func onCancelButtonTapHandler(_ sender: Any) {
        
        imageView.image = nil
        self.setTextFieldDefaultText()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {

        //Do not move view up if it is a TopTextField
        if(self.topTextField.isFirstResponder == true){
            return
        }
    
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func HideAndShowBars(_ isHidden: Bool) {
        topToolBar.isHidden = isHidden
        bottomToolBar.isHidden = isHidden
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hide top and bottom toolbars
        HideAndShowBars(true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show top and bottom toolbars
        HideAndShowBars(false)

        return memedImage
    }
    
}

