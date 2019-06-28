//
//  SentMemeTableViewController.swift
//  MemeTest
//
//  Created by xXxXx on 28/04/2019.
//  Copyright © 2019 abdullah. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController{

    var memes: [Meme]! {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell", for: indexPath)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel!.text = meme.topText
        cell.detailTextLabel!.text = meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.memes = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }


}
