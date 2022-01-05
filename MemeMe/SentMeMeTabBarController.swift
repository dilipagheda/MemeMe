//
//  SentMeMeTabBarController.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 5/1/22.
//

import Foundation
import UIKit


class SentMeMeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let plusImage = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(onPlusIconTapHandler))
    }
    
    @objc func onPlusIconTapHandler(){
        
        let memeEditorViewController = (storyboard!).instantiateViewController(identifier: "memeEditorViewController")
        memeEditorViewController.modalPresentationStyle = .fullScreen
        navigationController!.present(memeEditorViewController, animated: true)
    }
}
