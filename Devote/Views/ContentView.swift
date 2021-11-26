//
//  ContentView.swift
//  Devote
//
//  Created by Yok on 24/11/2564 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem : Bool = false
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    //FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //MARK: - BODY
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    // MARK: - HEADER
                    HStack(spacing: 10) {
                        // TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size : 16 , weight : .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70 , minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2))
                        // APPEARANCE BUTTON
                        Button(action: {
                            // TOGGLE APPEARANCE
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill":"moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24 )
                                .font(.system(.title ,design: .rounded))
                        })
                        
                    } //: HSTACK
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)
                    // MARK: - NEW TASK BUTTON
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,
                                          weight: .semibold
                                          ,design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24 , weight: .bold , design: .rounded))
                          
                    })
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical ,15)
                        .background(LinearGradient(colors: [Color.pink , Color.blue], startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .shadow(color: Color(red: 0, green: 0, blue: 0 , opacity : 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    
                    List {
                        ForEach(items) { item in
                            //      NavigationLink {
                            
                            ListRowItemView(item: item)
                            
//                            VStack(alignment: .leading) {
//                                Text(item.task ?? "0")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                    .font(.footnote)
//                                    .foregroundColor(.gray)
//
//                            }//: LIST ITEM
                          
                        }
                        .onDelete(perform: deleteItems)
                    } //:LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0 ,opacity :0.3 ),
                            radius: 12)
                    .padding(.vertical , 0)
                    .frame(maxWidth : 640)
                    
                    
                }//:VSTACK
                
                // MARK: - NEW TASK ITEM
                
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }//: ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            
            .navigationTitle("Daily Tasks")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//                //                ToolbarItem {
//                //                    Button(action: addItem) {
//                //                        Label("Add Item", systemImage: "plus")
//                //                    }
//                //                }
//            }// : TOOLBAR
            
            
            .background(
                BackgroundImageView())
            .background(
                backgroundGradient.ignoresSafeArea(.all))
            
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    
}
// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
