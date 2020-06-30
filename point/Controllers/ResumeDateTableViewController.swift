    //
    //  ResumeDateTableViewController.swift
    //  point
    //
    //  Created by mendy aouizerat  on 26/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    //
    
    import UIKit
    
    class ResumeDateTableViewController: UITableViewController {
        
        var Datedic :[String:Any]?
        var DatedicAsArr : [Any]?
        var actualleMonth:String?
        @IBAction func backButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            self.showProgress()
            // bring the dictionnary of guards from firebase  and making it as array and sort the array
            FirebaseModal.dataBaseRef.child(FirebaseModal.currentAuthName!).child(actualleMonth ?? "June").observeSingleEvent(of: .value) { (arr) in
                self.Datedic = arr.value as? [String:Any]
                
                self.DatedicAsArr = self.Datedic?.values.map({$0})
                self.DatedicAsArr?.sort(by: { (current, nexts) -> Bool in
                    let current = current as? [String:Any]
                    let date = current?["NoFromDate"] as? String
                    let nexts = nexts as? [String:Any]
                    let dateNext = nexts?["NoFromDate"] as? String
                    if date! < dateNext! {
                        
                        return true
                    }
                    return false
                })
                
                
                self.tableView.reloadData()
                guard let _ = self.DatedicAsArr else{
                    self.dismiss(animated: true) {
                        self.showError()
                    }
                    return
                }
                self.showSucess()
            }
            
            // Uncomment the following line to preserve selection between presentations
            //self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            //self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return self.DatedicAsArr?.count ?? 0
            
        }
        // set the cell for section
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionsTableViewCell
            let day = DatedicAsArr?[section] as? [String:Any]
            let nameOfDay = day?["Date"] as? String
            cell.sectionTitle.text = nameOfDay
            return cell
        }
        //set the height of the section
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionsTableViewCell
            return cell.fs_height+10
        }
        //set the row for each sections
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let day = DatedicAsArr?[section] as? [String:Any]
            return day?.count ?? 0
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resumecell", for: indexPath) as! GuardTableViewCell
            let day = DatedicAsArr?[indexPath.section] as? [String:Any]
            let guardes = day?.values.map({$0})
            let guarde = guardes?[indexPath.row] as? [String:Any]
            cell.logoutLabel.text = guarde?["out"] as? String ?? "00:00"
            cell.loginLabel.text = guarde?["in"] as? String ?? "00:00"
            
            
            return cell
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
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
        
    }
    
