//  SplashView.swift
//  Lumen
import SwiftUI
import Combine

struct SplashView: View {
    
    @State private var imagenActual = 0
        @State private var mostrarLogin = false

    let imagenes = ["Slider1 1","slider2 1","slider3 1"]
    let cafe = Color(red: 0.48, green: 0.27, blue: 0.15)
    let temporizador = Timer.publish(every: 3, on: .main,
                                        in: .common).autoconnect()


    var body: some View {
        Group {
                    if mostrarLogin {
                        LoginView()
                    } else {
                        VStack(spacing: 20){
                            Text("Lumen Panadería")
                                .font(.largeTitle).fontWeight(.bold)
                                .foregroundColor(cafe)

                            Image(imagenes[imagenActual])
                                .resizable().scaledToFit().frame(height: 280)

                            Text("El mejor sabor")
                                .font(.title).foregroundColor(.gray)
                            Text("Panadería y Repostería")
                                .multilineTextAlignment(.center)

                            Button(action: { self.mostrarLogin = true }) {
                                Text("Comenzar")
                                    .frame(maxWidth: .infinity).padding()
                                    .background(cafe).foregroundColor(.white)
                                    .cornerRadius(10)
                            }.padding(.horizontal, 30)
                        }
                        .padding()
                        .onReceive(temporizador) { _ in
                            self.imagenActual = (self.imagenActual + 1)
                                                % self.imagenes.count
                        }
                    }
                }
            }
        }


#Preview {
    SplashView()
}
