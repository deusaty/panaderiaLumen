//
//  PerfilView.swift
//  Lumen
//
//  Created by Alphonse on 03/11/26.
//

import SwiftUI
import FirebaseAuth

struct PerfilView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.crop.circle").font(.system(size: 75))
            Text(Auth.auth().currentUser?.displayName ?? "Cliente")
            Text(Auth.auth().currentUser?.email ?? "")
            Text("Cerrar sesión se conectará con el estado global de autenticación")
                .multilineTextAlignment(.center)
        }.padding()
    }
}

#Preview {
    PerfilView()
}
