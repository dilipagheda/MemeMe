//
//  SentMeMeTableViewController.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 3/1/22.
//

import Foundation
import UIKit

class SentMeMeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentMeMeTableViewCell", for: indexPath) as! SentMeMeTableViewCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        cell.memeLabel.text = "\(meme.topText)...\(meme.bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = memes[indexPath.row]

        performSegue(withIdentifier: SegueHelper.getSegueIdentifer(id: .memeDetailView), sender: meme)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let segueHelper = SegueHelper(segue, sender!)
        segueHelper.prepareSegue()
    }
}
