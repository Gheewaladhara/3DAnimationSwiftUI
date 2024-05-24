//
//  Home .swift
//  SwiftUI Project
//
//  Created by GHEEWALA DHARA on 08/05/24.
//

import SwiftUI
import SceneKit

struct Home : View {
    
    @State var scene: SCNScene? = .init(named: "TOM.scn") 
    
    //MARK: View Properties
    @State var isVerticalLook: Bool = false
     
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        
        HeaderView()
        VStack{
            // MARK:  3D Preview
            CustomSenceView(scene: $scene)
                .frame(height: 350)
                .padding(.top, -50)
                .padding(.bottom, -15)
                .zIndex(-10)
            
            CustomSeeker()
            
        }
        .padding()
    }
    
    
    //MARK: Custom Seeker
    
    @ViewBuilder
    func CustomSeeker()->some View{
        GeometryReader{_ in
            Rectangle()
            
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors: [
                    .clear,
                    .clear,
                    .white.opacity(0.2),
                    .white.opacity(0.6),
                    .white,
                    .white.opacity(0.6),
                    .white.opacity(0.2),
                    .clear,
                    .clear
                ], startPoint: .leading, endPoint: .trailing),style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [3], dashPhase: 1))
                .padding(.top)
                .offset(x: offset)
                .overlay {
                     // MARK: Seeker View
                    HStack(spacing: 3){
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                        
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    .offset(y: 5)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .updating($offset, body: { value , out, _ in
                                // reducing the Size of the knob
                                // Assuming the total size will be 40
                                // so reducing 40/2 -> 20
                                out = value.location.x - 20
                            })
                    )
                }
        }
        .frame(height: 20)
        .onChange(of: offset, perform: { newValue in
            rotateObject(animate: offset == .zero)
        })
        .animation(.easeInOut(duration: 0.4), value: offset == .zero)
    }
    
    //MARK: Rotating 3D Object Programatically
    func rotateObject(animate: Bool = false){
        // The rotatin is more or like same as 3D rotation in SwiftUI
        // Y will be used for horizontal Rotation
        // And Vice Vesera for X
//        if animate{
//            SCNTransaction.begin()
//            SCNTransaction.animationDuration = 0.6
//        }
        let newAngle = Float((offset * .pi) / 18)
        
        // MARK: Now Rotate The New Child Node
        if isVerticalLook{
            scene?.rootNode.childNode(withName: "Root", recursively:  true)?.eulerAngles.x = newAngle
        }else{
            scene?.rootNode.childNode(withName: "Root", recursively:  true)?.eulerAngles.y = newAngle
        }
        
        if animate{
            SCNTransaction.commit()
        }
    }
    
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView()->some View{
        HStack{
            Button {
                
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut){isVerticalLook.toggle()}
            } label: {
                Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: isVerticalLook ? 0 : 90))
                    .frame(width: 42, height: 42)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
                
            }

        }
    }
}

#Preview {
    ContentView()
}
