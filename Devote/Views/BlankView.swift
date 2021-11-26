//
//  BlankView.swift
//  Devote
//
//  Created by Yok on 25/11/2564 BE.
//

import SwiftUI

struct BlankView: View {
    //MARK: - PROPERTY
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer()
        }.frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, alignment: .center)
            .background(Color.black)
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
