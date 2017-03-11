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
import SCLAlertView

class KiteListVC: UITableViewController {
    
    var kiteViewController: KitePresentationViewController?
    let runner = KiteRunner.runner
    var bookmarks: [[String:String]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        present(kiteVC, animated: true, completion: nil)
    }
    
    func connectToKite() {
        
        let alertView = SCLAlertView()
        let txtName = alertView.addTextField("Name Prototype")
        let txtURL = alertView.addTextField("Link to Kite")
        alertView.addButton("Fly!") {
            guard let kiteURL = txtURL.text else {
                return
            }
            guard let kiteName = txtName.text else {
                return
            }
            self.flyKite(kiteName, kiteURL: kiteURL, saveBookmark: true)
        }
        alertView.showEdit("Fly a Kite", subTitle: "Name your prototype and enter a link to a zip file or dropbox folder")
    }
    
    func addTeaser() {
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Graphik-Regular", size: 20)!,
            kTextFont: UIFont(name: "Graphik-Regular", size: 16)!,
            kButtonFont: UIFont(name: "Graphik-Medium", size: 16)!,
            showCloseButton: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK", action: {
            
        })
        alertView.showInfo("Coming Soon", subTitle: "Kite saving is not currently available.")
        /*
        let alertController = UIAlertController(title: "Coming Soon", message: "Kite saving is not currently available.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)*/
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
