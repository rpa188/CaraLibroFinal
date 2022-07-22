//
//  ContactoTableViewCell.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/07/22.
//

import UIKit

class ContactoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var lblNombre: UILabel!
    @IBOutlet private weak var lblMensaje: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    
    //Para asignar los valores
    func updateData(_ contacto: Contacto) {
        
        self.animateAppear()
        self.lblNombre.text = "Titulooo"
        //self.lblNombre.text = contacto.name
        //self.lblMensaje.text = contacto.apellido

        /*
        for (index, imgStar) in self.arrayStars.enumerated() {
            imgStar.image = UIImage(systemName: index < contacto.voteAverage ? "star.fill" : "star")
        }
         */
        
        //let request = AF.request(contacto.urlImage)
        /*
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            let image = UIImage(data: data)
            self.imgContacto.image = image
        }
         */
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.imgMovie.layer.cornerRadius = 10
    }
    
    private func animateAppear() {
        
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
            self.transform = .identity
        }
    }
}
