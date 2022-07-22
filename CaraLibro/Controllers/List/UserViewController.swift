//
//  UserViewController.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 21/07/22.
//
import UIKit
import Firebase


class UserViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var users = [Room]()
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var reference: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate =    self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "DetailcellTableViewCell", bundle: nil), forCellReuseIdentifier: "Detailcell")
        getUsers()
    }
    private func getUsers()
    {
        reference = Database.database().reference()
        reference.child("users").observe(.value) { (users) in
            
            if let user = users.value as? [String: Any]
            {
                for objects  in user.values {
                    if let objectDictionary = objects as? [String:Any]
                    {
                      let name = objectDictionary["userName"] as? String
                      let age = objectDictionary["age"] as? String
                      let address = objectDictionary["address"] as? String
                      self.users.append(Room(username: name ?? ""  , age: age ?? "" , address: address ?? "" ))
                     }
                }
              
                self.tableview.reloadData()
                
            }
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detailcell") as! DetailcellTableViewCell
        print("age",users[indexPath.row].age)
        cell.nameLabel.text =
            "\(users[indexPath.row].username)"
        cell.cellTextView.text =
            " \(users[indexPath.row].address)"
        cell.Age.text =
            " \(users[indexPath.row].age)"
        
           return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    @IBAction func InfoBUTTON(_ sender: Any) {
    }
}
