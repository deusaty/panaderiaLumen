//
//  CarritoStore.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import Foundation

struct ItemCarrito: Identifiable {
    let producto: Productos
    var cantidad: Int
    var id: String { producto.id }
    var subtotal: Double { producto.precio * Double(cantidad) }
}


