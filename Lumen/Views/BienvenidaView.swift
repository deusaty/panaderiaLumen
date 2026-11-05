//
//  BienvenidaView.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import SwiftUI
import FirebaseAuth

struct BienvenidaView: View {
    @State private var irMenu = false
    let nombre: String
    let correo: String

    var body: some View {
        Group {
            if irMenu { MenuPrincipalView() }
            else {
                VStack(spacing: 18) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 90)).foregroundColor(.brown)
                    Text("¡Bienvenido, \(nombre)!").font(.title).bold()
                    Text(correo).foregroundColor(.gray)
                    ProgressView("Preparando tu panadería...")
                }
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        irMenu = true
                    }
                }
            }
        }
    }
}

struct BienvenidaView_Previews: PreviewProvider{
    static var previews: some View{
        BienvenidaView(nombre: "Alfonso", correo: "deusaty@gmail.com")
    }
}
