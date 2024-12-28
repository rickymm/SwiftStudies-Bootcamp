//
//  Crud.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 04/12/24.
//

import SwiftUI

struct AlertMessage: Identifiable {
    let id = UUID()
    let text: String
}

struct Crud: View {
    @State private var showActionSheet: Bool = false
    @State private var alertMessage: AlertMessage? = nil
    @State var items: [Category: [Item]] = [
        .fruit: [
            Item(name: "Banana", isCompleted: false)
        ],
        .vegetable: [
            Item(name: "Cucumber", isCompleted: false),
            Item(name: "Carrot", isCompleted: false)
        ]
    ]
    
    enum Category: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case fruit = "Fruits"
        case vegetable = "Vegetables"
    }

    struct Item: Identifiable {
        let id = UUID()
        var name: String
        var isCompleted: Bool
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(items.keys), id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        if let categoryItems = items[category] {
                            ForEach(categoryItems) { item in
                                Text(item.name)
                            }
                            .onDelete(perform: { indexSet in
                                deleteItem(at: indexSet, for: category)
                            })
                            .onMove(perform: { indices, newOffset in
                                moveItem(from: indices, to: newOffset, for: category)
                            })
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .confirmationDialog("Add fruit/vegetable", isPresented: $showActionSheet) {
                        AddButton(category: .fruit, action: addItem)
                        AddButton(category: .vegetable, action: addItem)
                    }
                }
            }
            .navigationTitle("Grocery List")
            .alert(item: $alertMessage) { message in
                Alert(title: Text(message.text))
            }
        }
    }
    
    func addItem(at category: Category) {
        let itemName = category == .fruit ? "Strawberry" : "Corn"
        items[category]?.append(Item(name: itemName, isCompleted: false))
        alertMessage = AlertMessage(text: "\(itemName) added to \(category.rawValue)")
            
    }
    
    func deleteItem(at indexSet: IndexSet, for category: Category) {
        items[category]?.remove(atOffsets: indexSet)
    }
    
    func moveItem(from indices: IndexSet, to newOffset: Int, for category: Category) {
        items[category]?.move(fromOffsets: indices, toOffset: newOffset)
    }
}


struct AddButton: View {
    let category: Crud.Category
    let action: (Crud.Category) -> Void
    
    var body: some View {
        Button {
            action(category)
        } label: {
            Text(category == .fruit ? "Fruit 🍓" : "Vegetable 🌽")
        }
    }
}


#Preview {
    Crud()
}
