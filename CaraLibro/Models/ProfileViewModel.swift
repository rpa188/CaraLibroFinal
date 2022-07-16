//
//  ProfileViewModel.swift
//  CaraLibro
//
//  Created by Ronald Publicidad on 16/07/22.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
