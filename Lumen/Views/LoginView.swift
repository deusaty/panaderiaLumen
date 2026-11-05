//  LoginView.swift
//  Lumen



import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var correo = ""
    @State private var password = ""
    @State private var mensaje = ""
    @State private var acceso = false
    @State private var loginExitoso = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    let cafe = Color(red: 0.48, green: 0.27, blue: 0.15)
    
    var body: some View {
        Group {
            if loginExitoso {
                BienvenidaView(
                    nombre: Auth.auth().currentUser?.displayName ?? "Cliente",
                    correo: Auth.auth().currentUser?.email ?? ""
                )
            } else {
                NavigationStack {
                    VStack(spacing: 16) {
                        Image(systemName: "bag.fill").font(.system(size: 60))
                            .foregroundColor(.brown)
                        Text("Lumen Panadería").font(.largeTitle).bold()
                        TextField("Correo electrónico", text: $correo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none).keyboardType(.emailAddress)
                        SecureField("Contraseña", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Ingresar") {
                            AuthService.shared.ingresar(correo: correo, password: password) { error in
                                DispatchQueue.main.async {
                                    if let error = error {
                                        mensajeError = "No se pudo iniciar sesión. Verifica tus datos o conexión."
                                        print("Login Firebase: \(error.localizedDescription)")
                                        mostrarError = true
                                    } else {
                                        loginExitoso = true
                                    }
                                }
                            }
                        }.disabled(correo.isEmpty || password.isEmpty)
                        NavigationLink("Registrarse", destination: RegistroView())
                        NavigationLink("Recuperar contraseña", destination: RecuperarPasswordView())
                        NavigationLink("Comprar como invitado", destination: CatalogoView())
                        if !mensaje.isEmpty { Text(mensaje).foregroundColor(.red) }
                        Spacer()
                    }
                    .padding(24)
                    .navigationDestination(isPresented: $acceso) {
                        CatalogoView()
                    }
                }
                .alert(isPresented: $mostrarError) {
                    Alert(title: Text("No fue posible ingresar"),
                          message: Text(mensajeError), dismissButton: .default(Text("Aceptar")))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
