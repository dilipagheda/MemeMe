//
//  MeMeDetailViewController.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 5/1/22.
//

import Foundation
import UIKit

class MeMeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
    }
}
