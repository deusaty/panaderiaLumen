//
//  ProductosService.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import Foundation
import Combine
import FirebaseFirestore

final class ProductosService: ObservableObject {
    
    @Published var productos: [Productos] = []
    @Published var mensajeError = ""
    private let db = Firestore.firestore()

    func cargar() {
        db.collection("productos").getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.mensajeError = error.localizedDescription
                    return
                }
                self?.mensajeError = ""
                self?.productos = snapshot?.documents.compactMap { doc in
                    let d = doc.data()
                    guard let nombre = d["nombre"] as? String,
                          let precio = (d["precio"] as? NSNumber)?.doubleValue,
                          let existencia = (d["existencia"] as? NSNumber)?.intValue else { return nil }
                    return Productos(id: doc.documentID, nombre: nombre,
                        descripcion: d["descripcion"] as? String ?? "",
                        categoria: d["categoria"] as? String ?? "",
                        precio: precio, existencia: existencia,
                        imagenURL: d["imagenURL"] as? String ?? "")
                } ?? []
            }
        }
    }
}

