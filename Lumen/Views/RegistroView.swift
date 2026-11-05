//  RegistroView.swift
//  Lumen

import SwiftUI

struct RegistroView: View {
    
    @State private var nombre = ""
    @State private var correo = ""
    @State private var telefono = ""
    @State private var direccion = ""
    @State private var password = ""
    @State private var confirmar = ""
    @State private var mensaje = ""
    @State private var listo = false
    @State private var cargando = false
    
    
    var body: some View {
        Form {
            Section(header: Text("Datos personales")) {
                TextField("Nombre completo", text: $nombre)
                TextField("Correo electrónico", text: $correo)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                TextField("Teléfono", text: $telefono)
                    .keyboardType(.phonePad)
                TextField("Dirección", text: $direccion)
            }
            
            Section(header: Text("Acceso")) {
                            SecureField("Contraseña", text: $password)
                            SecureField("Confirmar contraseña", text: $confirmar)
                        }
                        Button(cargando ? "Guardando..." : "Crear cuenta") {
                            guard !nombre.isEmpty && !correo.isEmpty && !telefono.isEmpty &&
                                  !direccion.isEmpty else { mensaje = "Completa los campos"; return }
                            guard password.count >= 6 else {
                                mensaje = "La contraseña debe tener al menos 6 caracteres"; return
                            }
                            
                            guard password == confirmar else {
                                                mensaje = "Las contraseñas no coinciden"; return
                                            }
                                            cargando = true
                                            AuthService.shared.registrar(nombre: nombre, correo: correo,
                                                password: password, telefono: telefono, direccion: direccion) { error in
                                                DispatchQueue.main.async {
                                                    cargando = false
                                                    if let error = error { mensaje = error.localizedDescription }
                                                    else { mensaje = "Cuenta creada correctamente"; listo = true }
                                                }
                                            }
                                        }.disabled(cargando)
                                    }
        .navigationTitle("Registro")
                .alert(isPresented: $listo) {
                    Alert(title: Text("Registro exitoso"), message: Text(mensaje),
                          dismissButton: .default(Text("Aceptar")))
                }
                .overlay(VStack { if !mensaje.isEmpty && !listo {
                    Text(mensaje).foregroundColor(.red).padding()
                } }, alignment: .bottom)
            }
        }



    

