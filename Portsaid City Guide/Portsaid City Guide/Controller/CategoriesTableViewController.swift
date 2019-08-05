//
//  CategoriesTableViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/23/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var cellContent : [Categories] = []
    var selectedType : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        cellContent = createCategories()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (cellContent.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! CategoriesTableViewCell
        
        cell.updateCell(category: cellContent[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = self.cellContent[indexPath.row].title
        performSegue(withIdentifier: "goToPlacesVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlacesVC"{
            let nextVC = segue.destination as! PlacesViewController
            nextVC.selectedType = selectedType.lowercased()
        }
    }
    
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

    func createCategories()->[Categories]{
        var temp : [Categories] = []
        temp.append(Categories(image: #imageLiteral(resourceName: "lily-banse-540998-unsplash.jpg"), title: "Cafe"))
        temp.append(Categories(image: #imageLiteral(resourceName: "hospital"), title: "Hospital"))
        temp.append(Categories(image: #imageLiteral(resourceName: "restaurant"), title: "Restaurant"))
        temp.append(Categories(image: #imageLiteral(resourceName: "schools"), title: "School"))
        temp.append(Categories(image: #imageLiteral(resourceName: "supermarket"), title: "Supermarket"))
        temp.append(Categories(image: #imageLiteral(resourceName: "hotels"), title: "Hotels"))
        temp.append(Categories(image: #imageLiteral(resourceName: "cinema"), title: "Cinema"))
        temp.append(Categories(image: #imageLiteral(resourceName: "dollars"), title: "Bank"))
        temp.append(Categories(image: #imageLiteral(resourceName: "parking"), title: "Parking"))
        temp.append(Categories(image: #imageLiteral(resourceName: "gym"), title: "Gym"))
        
        
        return temp
    }
    
}












