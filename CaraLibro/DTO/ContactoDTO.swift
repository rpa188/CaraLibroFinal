//
//  ContactoDTO.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/07/22.
//

import Foundation

struct PageContactoDTO: Decodable {
    let results: [ContactoDTO]?
}

struct ContactoDTO: Decodable {
    let id: String?
    let apellido: String?
    let name: String?
    let email: String?
    let imagen_perfil_path: String?
}
