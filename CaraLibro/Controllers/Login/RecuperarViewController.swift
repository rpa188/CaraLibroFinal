//
//  RecuperarViewController.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 23/06/22.
//

import UIKit
import Firebase
import FirebaseAuth
class RecuperarViewController: UIViewController {
    
    @IBOutlet private weak var emailTextFieldRecovery: UITextField!
    
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
    
    
    
    
    @IBAction func forgotPassBtn(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailTextFieldRecovery.text!) { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "problemas", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            /*
            
            let alert = UIAlertController(title: "Hurra", message: "Se ha enviado a su correo para restablecer contraseña", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            */
            
            let alert = UIAlertController(title: "Listo!",
                                                   message: "Se ha enviado un mail de restablecimiento en su bandeja.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

//MARK: - Keyboard events
extension RecuperarViewController {
    
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


