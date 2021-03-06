//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Yok on 25/11/2564 BE.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task : String = ""
    @Binding var isShowing: Bool
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
   
    
    
    // MARK: - FUNCTION
    
    private func addItem() {
        withAnimation {
            
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack (spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24 , weight: .bold ,
                                  design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
//                        Color(UIColor.systemGray6)
                    )
                    .cornerRadius(10)
                Button(action:{ addItem()
                    
                },
                       label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24 ,weight: .bold ,
                                      design: .rounded))
                    Spacer()
                    
                })
                    .disabled(isButtonDisabled)
                    .padding()
             
                    .foregroundColor(.white)
                    .background(isButtonDisabled ? Color.blue : Color.pink)
                    .cornerRadius(10)
                
            } //: VSTACK
            .padding(.horizontal )
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) :Color.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0 , opacity : 0.65), radius: 24, x: 0.0, y: 0.0)
            .frame(maxWidth: 640)
        } // : VStack
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
