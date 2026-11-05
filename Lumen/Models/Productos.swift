//
//  Productos.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import Foundation

struct Productos: Identifiable {
    
    let id: String
    let nombre: String
    let descripcion: String
    let categoria: String
    let precio: Double
    let existencia: Int
    let imagenURL: String
    var disponible: Bool { existencia > 0 }
}

