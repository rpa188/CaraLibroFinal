//
//  ContactoWS.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 19/07/22.
//

import Foundation
import FirebaseDatabase

typealias ContactosDTOHandler = (_ arrayContactosDTO: [ContactoDTO]) -> Void

private let database = Database.database().reference()

//var firebaseRootRef = firebase.database().ref()
//var personal_Ref = firebaseRootRef.child('users')

struct ContactoWS {

    
    func getAllContactos(contactosHandler: @escaping ContactosDTOHandler) {
        
        /*
            let urlString =  "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
               let request = AF.request(urlString, method: .get)
          
        
        
            database.response { dataResponse in
                   
                   guard let data = dataResponse.data else {
                       contactosHandler([])
                       return
                   }
                   
                   let decoder = JSONDecoder()
                   let response = try? decoder.decode(PageContactoDTO.self, from: data)
                   let arrayContactos = response?.results ?? []
                   contactosHandler(arrayContactos)
               }
         */
        }
    }

