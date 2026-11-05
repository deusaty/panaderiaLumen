//  CatalogoView.swift
//  Lumen

import SwiftUI

struct CatalogoView: View {
    @EnvironmentObject var carrito: CarritoStore
    @StateObject private var servicio = ProductosService()

    var body: some View {
        NavigationView {
            List {
                ForEach(servicio.productos) { p in
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: p.imagenURL)) { imagen in
                            imagen.resizable().scaledToFill()
                        } placeholder: { ProgressView() }
                        .frame(width: 85, height: 85).clipped()
                        VStack(alignment: .leading, spacing: 5) {
                            Text(p.nombre).font(.headline)
                            Text(String(format: "$%.2f", p.precio))
                            Text(p.disponible ? "Disponible" : "Agotado")
                                .foregroundColor(p.disponible ? .green : .red)
                            Button(action: { carrito.agregar(p) }) {
                                Label("Agregar", systemImage: "cart.badge.plus")
                            }.disabled(!p.disponible)
                        }
                    }
                }
                if !servicio.mensajeError.isEmpty {
                    Text(servicio.mensajeError).foregroundColor(.red)
                }
            }
            .navigationTitle("Catálogo")
            .onAppear { servicio.cargar() }
        }
    }
}

