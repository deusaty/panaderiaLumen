//
//  CarritoView.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import SwiftUI

struct CarritoView: View {
    @EnvironmentObject var carrito: CarritoStore
    var body: some View {
        NavigationView {
            VStack {
                if carrito.items.isEmpty {
                    Spacer()
                    Image(systemName: "cart").font(.largeTitle)
                    Text("Tu carrito está vacío")
                    Spacer()
                } else {
                    List {
                        ForEach(carrito.items) { item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.producto.nombre).bold()
                                Text(String(format: "$%.2f c/u", item.producto.precio))
                                HStack {
                                    Button("−") { carrito.disminuir(item.id) }
                                    Text("\(item.cantidad)")
                                    Button("+") { carrito.agregar(item.producto) }
                                    Spacer()
                                    Text(String(format: "$%.2f", item.subtotal))
                                    Button(action: { carrito.eliminar(item.id) }) {
                                        Image(systemName: "trash")
                                    }
                                }.buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    Text(String(format: "Total: $%.2f", carrito.total))
                        .font(.title2).bold()
                    Button("Vaciar carrito") { carrito.vaciar() }
                        .foregroundColor(.red).padding()
                }
            }
            .navigationTitle("Carrito")
        }
    }
}


#Preview {
    CarritoView()
}
