//
//  AuthService.swift
//  
//
//  Created by Alphonse on 20/10/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    static let shared = AuthService()
    private let db = Firestore.firestore()
 
    func registrar(nombre: String, correo: String, password: String,
                   telefono: String, direccion: String,
                   completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: correo, password: password) { result, error in
            if let error = error { completion(error); return }
            guard let uid = result?.user.uid else {
                completion(NSError(domain: "Registro", code: -1)); return
            }
            self.db.collection("usuarios").document(uid).setData([
                "nombre": nombre, "correo": correo,
                "telefono": telefono, "direccion": direccion,
                "fechaRegistro": FieldValue.serverTimestamp()
            ]) { error in completion(error) }
        }
    }
    
    func ingresar(correo: String, password: String,
                 completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: correo, password: password) { _, error in
            completion(error)
        }
    }
 
    func recuperar(correo: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: correo, completion: completion)
    }
}


