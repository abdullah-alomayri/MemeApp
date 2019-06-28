//
//  SentMemeDetailViewController.swift
//  MemeTest
//
//  Created by xXxXx on 03/05/2019.
//  Copyright © 2019 abdullah. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController {
    var memes: Meme!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.memes.topText
          self.label.text = self.memes.bottomText
    
        self.imageView!.image = memes.memedImage
        
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }


}
