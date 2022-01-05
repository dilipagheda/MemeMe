//
//  SegueHelper.swift
//  MemeMe
//
//  Created by Dilip Agheda on 5/1/22.
//

import Foundation
import UIKit

enum SegueIdentifiers {
    case memeDetailView
}

class SegueHelper {
    
    var segue: UIStoryboardSegue?
    var sender: Any?
    
    static func getSegueIdentifer(id: SegueIdentifiers) -> String {
        
        switch(id) {
        case .memeDetailView:
            return "showMeMeDetailView"
        }
    }
    
    init(_ segue: UIStoryboardSegue,_ sender: Any){
        self.segue = segue
        self.sender = sender
    }

    func prepareSegue() {
        
        if(segue!.identifier==SegueHelper.getSegueIdentifer(id: .memeDetailView))
        {
            let meme = sender as! Meme
            let memeDetailVC = segue!.destination as! MeMeDetailViewController
            memeDetailVC.meme = meme
        }
    }
}
