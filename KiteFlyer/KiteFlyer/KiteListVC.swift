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

class KiteListVC: UITableViewController {
    
    var kiteViewController: KitePresentationViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        //editButtonItem.tintColor = UIColor.white
    }

    @IBAction func kiteTapped(_ sender: Any) {
        connectToKite()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        addTeaser()
    }
    
    func flyKite(kiteURL: String) {
        print(kiteURL)
    }
    
    func connectToKite() {
        let alertController = UIAlertController(title: "Fly a Kite", message: "Enter a link to a zip file or dropbox folder", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let flyAction = UIAlertAction(title: "Fly!", style: .default) { (action) in
            guard let theKite = alertController.textFields?[0] else {
                return
            }
            guard let kiteURL = theKite.text else {
                return
            }
            self.flyKite(kiteURL: kiteURL)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Link to kite"
            textField.keyboardType = .URL
        }
        alertController.addAction(cancelAction)
        alertController.addAction(flyAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addTeaser() {
        let alertController = UIAlertController(title: "Coming Soon", message: "Kite saving is not currently available.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
