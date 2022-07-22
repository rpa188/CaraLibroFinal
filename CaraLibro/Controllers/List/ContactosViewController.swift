//
//  ContactosViewController.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/07/22.
//

import UIKit
import FirebaseDatabase

class ContactosViewController: UIViewController {
    
    var databaseRef: DatabaseReference?
    
    var ref: DatabaseReference!
    var contactos: [DataSnapshot]! = []
    var msglength: NSNumber = 10
    fileprivate var _refHandle: DatabaseHandle?
    
    
    @IBOutlet private weak var tlvContactos: UITableView!
        /*
        didSet {
            tlvContactos.dataSource = self
        }
         */

   
    
    var arrayContactos = [Contacto]()
    //var items : [Contacto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tlvContactos.dataSource = self
        
        configureDatabase()
        
        /*
        //Funciono para traer Data de una coleccion simple
        databaseRef = Database.database().reference().child("users")
        databaseRef?.observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            //el value contiene el arreglo con los datos
            guard let value = snapshot.value as? [String: Any] else {return}
            print("Key is : \(key). Value is: \(value)")
            self.arrayContactos = snapshot.childSnapshot(forPath: "users").children.allObjects as! [Contacto]
            
        }
            */
    }
    
    func configureDatabase() {
      ref = Database.database().reference()
      // Listen for new messages in the Firebase database
      _refHandle = self.ref.child("users").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
        guard let strongSelf = self else { return }
        strongSelf.contactos.append(snapshot)
        strongSelf.tlvContactos.insertRows(at: [IndexPath(row: strongSelf.contactos.count-1, section: 0)], with: .automatic)
      })
    }
}

//UI TableView Data
extension ContactosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("el array es : " , arrayContactos)
        //return self.arrayContactos.count
        print("el numero de contactos es: \(contactos.count)")
        
        return contactos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableContacto", for: indexPath) as? ContactoTableViewCell
        
        let objContacto = self.arrayContactos[indexPath.row]
        print("el objcontacto es: ", objContacto)
        cell?.updateData(objContacto)
        
        return cell ?? UITableViewCell()
         */
        /*
        let cell = self.tlvContactos.dequeueReusableCell(withIdentifier: "tableContacto", for: indexPath)
        return cell
         */
        // Unpack message from Firebase DataSnapshot
        let cell = self.tlvContactos.dequeueReusableCell(withIdentifier: "tableContacto", for: indexPath)
        /*
        let contactoSnapshot: DataSnapshot! = self.contactos[indexPath.row]
        guard let contacto = contactoSnapshot.value as? [String:String] else { return cell }
        let name = contacto[Constants.MessageFields.name] ?? ""
        cell.textLabel?.text = name
         */
        let contactoSnapshot: DataSnapshot! = self.contactos[indexPath.row]
        let objContact = self.contactos[indexPath.row]
        
        guard let contacto = contactoSnapshot.value as? [String:String] else { return cell }
        print("el contacto es : \(contacto)")
        
        cell.textLabel?.text = objContact.title
        //let name = contacto[Constants.MessageFields.name] ?? ""
        
        return cell
    }
    
    
}

