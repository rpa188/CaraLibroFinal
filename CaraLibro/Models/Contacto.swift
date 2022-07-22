//
//  Contacto.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/07/22.
//

import Foundation

struct Contacto {
    
    let id: String
    let name: String
    let email: String
    let fotoPath: String
    
    init(id: String, name: String, email:String, fotoPath:String){
        self.id = id
        self.name = name
        self.email = email
        self.fotoPath = fotoPath
        
    }
}
/*
struct Contacto {
    
    let id: String
    let name: String
    let email: String
    let fotoPath: String
    
    var urlImage: String {
        return "https://image.tmdb.org/t/p/w500" + self.fotoPath
    }
    
    //Contruyo a partir del DTO
    init(dto: ContactoDTO) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.email = dto.email ?? ""
        self.fotoPath = dto.imagen_perfil_path ?? ""
    }
}

extension ContactoDTO {
    //Transformato a tipo Contacto
    var toContacto: Contacto {
        return Contacto(dto: self)
    }
}

extension Array where Element == ContactoDTO {
    
    var toContactos: [Contacto] {
        self.map({ $0.toContacto })
    }
}
*/
