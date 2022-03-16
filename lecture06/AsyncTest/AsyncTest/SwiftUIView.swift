//
//  SwiftUIView.swift
//  AsyncTest
//
//  Created by dong jun park on 2022/03/07.
//

import SwiftUI

struct SwiftUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var count = 0
    
    var body: some View {
        
        Button("dismiss", action: {
            count = count+1
            print(count)
            if count == 5 {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
