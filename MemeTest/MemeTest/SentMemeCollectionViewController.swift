//
//  SentMemeCollectionViewController.swift
//  MemeTest
//
//  Created by xXxXx on 28/04/2019.
//  Copyright © 2019 abdullah. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemeCollectionViewCell"

class SentMemeCollectionViewController: UICollectionViewController {
    
   
    var memes: [Meme]! {
        didSet{
            collectionView.reloadData()
        }
    }
    
     @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    

   
    override func viewDidLoad() {
     super.viewDidLoad()
        
// Do any additional setup after loading the view.
        let space : CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
      
        cell.memeImageView.image =  meme.memedImage
       
        return cell

    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.memes = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    // MARK: UICollectionViewDelegate
}
