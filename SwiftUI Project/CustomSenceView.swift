//
//  CoustomSenceView.swift
//  SwiftUI Project
//
//  Created by GHEEWALA DHARA on 08/05/24.
//

import SwiftUI
import SceneKit

struct CustomSenceView: UIViewRepresentable {
    
    @Binding var scene : SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        
    }
}

#Preview {
    ContentView()
}
