//
//  SentMeMeCollectionViewController.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 3/1/22.
//

import Foundation
import UIKit

class SentMeMeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func calculateItemSize(_ frameWidth: CGFloat) {
        let space:CGFloat = 3.0
        let dimension = (frameWidth - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        calculateItemSize(view.frame.size.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        calculateItemSize(size.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]

        performSegue(withIdentifier: SegueHelper.getSegueIdentifer(id: .memeDetailView), sender: meme)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueHelper = SegueHelper(segue, sender!)
        segueHelper.prepareSegue()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMeMeCollectionViewCell", for: indexPath) as! SentMeMeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
   
}
