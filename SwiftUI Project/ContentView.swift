//
//  ContentView.swift
//  SwiftUI Project
//
//  Created by GHEEWALA DHARA on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false , content: {
            Home()
        })
        .preferredColorScheme(.dark )
    }
}

#Preview {
    ContentView()
}
