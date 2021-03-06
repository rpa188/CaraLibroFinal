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
    
    @IBOutlet weak var imageView: UIImageView!
    
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
        

        // Realice cualquier configuración adicional después de cargar la vista
    }

    @IBAction func adjuntarImagen(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    @IBAction func registroBtnAction(_ sender: Any) {
        
        
        guard let name = nameTextField.text,
            let apellido = apellidoTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !name.isEmpty,
            !apellido.isEmpty,
            !email.isEmpty,
              password.count >= 6 else {
                alertUserLoginError()
                return
        }

       
        // Firebase Log In
    DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
        guard let strongSelf = self else {
            return
        }


        guard !exists else {
            // El usuario ya existe
            strongSelf.alertUserLoginError(message: "Parece que ya existe una cuenta de usuario para esa dirección de correo electrónico.")
            return
        }

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("Error al crear el usuario")
                return
            }

            UserDefaults.standard.setValue(email, forKey: "email")
            UserDefaults.standard.setValue("\(name) \(apellido)", forKey: "name")


            let chatUser = ChatAppUser(name: name,
                                      apellido: apellido,
                                      email: email)
            DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                if success {
                    // Cargar imagen
                    guard let image = strongSelf.imageView.image,
                        let data = image.pngData() else {
                            return
                    }
                    let filename = chatUser.profilePictureFileName
                    StorageManager.shared.uploadProfilePicture(with: data, fileName: filename, completion: { result in
                        switch result {
                        case .success(let downloadUrl):
                            UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                            print(downloadUrl)
                        case .failure(let error):
                            print("Storage maanger error: \(error)")
                        }
                    })
                    self?.performSegue(withIdentifier: "registerHome", sender: nil)
                }
            })
            

            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    })
        
        
        
        
        
        
        
        
        /*
        
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
        
         */
        
        
    }
    
    func alertUserLoginError(message: String = "Por favor ingrese toda la información para crear una nueva cuenta.") {
        let alert = UIAlertController(title: "Ups",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //Probar opcion 2 Firebase Log In
    @objc private func registerButtonTapped() {
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
