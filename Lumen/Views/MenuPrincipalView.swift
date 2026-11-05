//
//  MenuPrincipalView.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import SwiftUI
import FirebaseAuth

struct MenuPrincipalView: View {
    @StateObject private var carrito = CarritoStore()
    var body: some View {
        TabView {
            VStack(spacing: 16) {
                Image(systemName: "house.fill").font(.system(size: 55))
                Text("Panaderia Lumen").font(.largeTitle)
                Text("El mejor pan artesanal")
            }.tabItem { Label("Inicio", systemImage: "house") }
            CatalogoView().tabItem { Label("Catálogo", systemImage: "bag") }
            CarritoView().tabItem { Label("Carrito", systemImage: "cart") }
            PerfilView().tabItem { Label("Perfil", systemImage: "person") }
        }
        .environmentObject(carrito)
    }
}





#Preview {
    MenuPrincipalView()
}
