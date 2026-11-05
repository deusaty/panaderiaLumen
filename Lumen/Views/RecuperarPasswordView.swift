//  RecuperarPasswordView.swift
//  Lumen

import SwiftUI

struct RecuperarPasswordView: View {
    @State private var correo = ""
    @State private var mensaje = ""
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.shield").font(.system(size: 65))
            Text("Recuperar contraseña").font(.title).bold()
            TextField("Correo electrónico", text: $correo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none).keyboardType(.emailAddress)
            Button("Enviar enlace") {
                AuthService.shared.recuperar(correo: correo) { error in
                    DispatchQueue.main.async {
                        mensaje = error == nil ?
                            "Si la cuenta es válida, revisa tu correo." :
                            "No se pudo procesar la solicitud. Intenta de nuevo."
                    }
                }
            }.disabled(correo.isEmpty)
            Text(mensaje).multilineTextAlignment(.center)
            Spacer()
        }.padding().navigationTitle("Recuperación")
    }
}

