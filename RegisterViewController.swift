//
//  RegisterViewController.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 22/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var apellidoTextField: UITextField!
    
    @IBOutlet weak var registroBtn: UIButton!
    
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var anchorCenterContentY: NSLayoutConstraint!
    
    @IBAction private func tapToCloseKeyboard( _ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotifications()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registroBtnAction(_ sender: Any) {
        
        let name = nameTextField.text
        let apellido = apellidoTextField.text
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                result, error in
                if let result = result, error == nil {
                    let object:  [String: Any] = [
                        "email": email,
                        "password": password,
                        "name" : name,
                        "apellido" : apellido
                    ]
                    self.database.child("user").setValue(object)
                    self.performSegue(withIdentifier: "registerHome", sender: nil)
                    /*
                    self.navigationController?.pushViewController(HomeWViewController(email: result.user.email!, provider: .basic), animated: true)
                     */
                }else {
                    let alerController = UIAlertController(title: "Error",
                                                           message: "Se ha producido un error registrando el nuevo usuario", preferredStyle: .alert)
                    alerController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alerController, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
}
//MARK: - Keyboard events
extension RegisterViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        if keyboardFrame.origin.y < self.viewContent.frame.maxY {
            UIView.animate(withDuration: animationDuration) {
                self.anchorCenterContentY.constant = keyboardFrame.origin.y - self.viewContent.frame.maxY
                self.view.layoutIfNeeded()
            }
        }
        

    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        UIView.animate(withDuration: animationDuration) {
            self.anchorCenterContentY.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

