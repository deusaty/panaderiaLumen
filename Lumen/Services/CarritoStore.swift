//
//  CarritoStore.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import Foundation
import Combine

final class CarritoStore: ObservableObject {
    
    @Published var items: [ItemCarrito] = []
    var total: Double { items.reduce(0) { $0 + $1.subtotal } }
    var unidades: Int { items.reduce(0) { $0 + $1.cantidad } }

    func agregar(_ p: Productos) {
        guard p.disponible else { return }
        if let i = items.firstIndex(where: { $0.id == p.id }) {
            if items[i].cantidad < p.existencia { items[i].cantidad += 1 }
        } else { items.append(ItemCarrito(producto: p, cantidad: 1)) }
    }
    func disminuir(_ id: String) {
        guard let i = items.firstIndex(where: { $0.id == id }) else { return }
        if items[i].cantidad > 1 { items[i].cantidad -= 1 }
        else { items.remove(at: i) }
    }
    func eliminar(_ id: String) { items.removeAll { $0.id == id } }
    func vaciar() { items.removeAll() }
}

