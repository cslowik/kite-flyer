//
//  KiteListVC.swift
//  KiteFlyer
//
//  Created by Chris Slowik on 3/9/17.
//  Copyright © 2017 Chris Slowik. All rights reserved.
//

import UIKit
import AVFoundation
import JavaScriptCore
import MobileCoreServices
import KiteKit
import PMAlertController

class KiteListVC: UITableViewController {
    
    var kiteViewController: KitePresentationViewController?
    let runner = KiteRunner.runner
    var bookmarks: [[String:String]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        //editButtonItem.tintColor = UIColor.white
        bookmarks = runner.bookmarks ?? []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bookmarks = runner.bookmarks ?? []
        tableView.reloadData()
    }

    @IBAction func kiteTapped(_ sender: Any) {
        connectToKite()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        addTeaser()
    }
    
    func flyKite(_ kiteName: String, kiteURL: String, saveBookmark: Bool) {
        let kiteVC = PlayerVC()
        kiteVC.url = kiteURL
        kiteVC.name = kiteName
        kiteVC.isNew = saveBookmark
        kiteVC.modalTransitionStyle = .crossDissolve
        present(kiteVC, animated: true, completion: nil)
    }
    
    func connectToKite() {
        
        let alertVC = PMAlertController(title: "Fly a Kite", description: "Name your kite prototype, and provide the link to its location (zip file or dropbox folder)", image: #imageLiteral(resourceName: "kiteIllustration-large"), style: .alert)
        alertVC.gravityDismissAnimation = false
        
        alertVC.addTextField { (textField) in
            textField?.placeholder = "Kite Name..."
        }
        alertVC.addTextField { (textField) in
            textField?.placeholder = "Kite URL..."
        }
        
        alertVC.addAction(PMAlertAction(title: "Fly!", style: .default, action: { () in
            guard let theName = alertVC.textFields[0].text else {
                return
            }
            guard let theURL = alertVC.textFields[1].text else {
                return
            }
            self.flyKite(theName, kiteURL: theURL, saveBookmark: true)
        }))
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () in
            alertVC.gravityDismissAnimation = true
        }))
        
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func addTeaser() {
        let alertVC = PMAlertController(title: "Coming Soon", description: "Offline mode is not currently available", image: nil, style: .alert)
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
        }))
        present(alertVC, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let kiteName = runner.bookmarks![indexPath.row]["name"] else {
            return
        }
        guard let kiteURL = runner.bookmarks![indexPath.row]["url"] else {
            return
        }
        
        flyKite(kiteName, kiteURL: kiteURL, saveBookmark: false)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = bookmarks[indexPath.row]["name"]
        cell.textLabel?.textColor = UIColor.white.withAlphaComponent(0.85)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.tableCellOverlay
        cell.textLabel?.backgroundColor = UIColor.clear
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        }
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard runner.bookmarks != nil else {
                return
            }
            runner.bookmarks!.remove(at: indexPath.row)
            bookmarks = runner.bookmarks!
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
