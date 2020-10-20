//
//  ContentView.swift
//  ColorSwiftUI
//
//  Created by Елена Червоткина on 19.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var colorR = Double.random(in: 0...255)
    @State private var colorG = Double.random(in: 0...255)
    @State private var colorB = Double.random(in: 0...255)
    
    var body: some View {
        ZStack{
            Color(.systemTeal).edgesIgnoringSafeArea(.all)
            VStack{
                Color(red: colorR/255, green: colorG/255, blue: colorB/255)
                    .frame(height: 150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.white)
                    )
                
                ColorBlock(value: $colorR, stringValue: "\(lround(colorR))", color: .red)
                ColorBlock(value: $colorG, stringValue: "\(lround(colorG))", color: .green)
                ColorBlock(value: $colorB, stringValue: "\(lround(colorB))", color: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ColorBlock: View{
    @Binding var value: Double
    @State var stringValue: String
    @State private var showAlert = false
    let color : Color
    
    
    var body: some View {
        HStack(alignment: .center){
            Text(stringValue)
                .lineLimit(1)
                .frame(width: 40)
            
            Slider(value: $value, in: 0...255, step: 1){_ in
                stringValue = "\(lround(value))"
            }
            .accentColor(color)
            
            TextField("", text: $stringValue, onEditingChanged: {_ in checkNumber()})
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Wrong Format!"), message: Text("Enter number from 0 to 255"))
                })
                .frame(width: 40, height: 30)
                .multilineTextAlignment(.trailing)
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                .background(Color.white)
                .cornerRadius(3)
                .keyboardType(.numberPad)
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
        
    }
    
    private func checkNumber() {
        if let newValue = Double(stringValue), newValue >= 0, newValue <= 255{
            value = newValue
            stringValue = "\(lround(value))"
            showAlert = false
        } else {
            value = 0
            stringValue = "0"
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
