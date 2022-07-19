//
//  LoginViewController.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/06/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
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

        // Realice cualquier configuración adicional después de cargar la vista.
    }
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                result, error in
                if let _ = result, error == nil {
                    self.performSegue(withIdentifier: "Home", sender: nil)
                    /*
                    self.navigationController?.pushViewController(HomeWViewController(email: result.user.email!, provider: .basic), animated: true)
                     */
                }else {
                    let alerController = UIAlertController(title: "Error",
                                                           message: "Se ha producido un error, usuario o contraseña incorrecta", preferredStyle: .alert)
                    alerController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alerController, animated: true, completion: nil)
                }
            }
        }
    }
    

    
}
//MARK: - Keyboard events
extension LoginViewController {
    
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

