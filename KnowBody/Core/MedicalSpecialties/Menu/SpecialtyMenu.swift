//
//  SpecialtySelectorView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/31/25.
//
import SwiftUI

struct SpecialtyMenu: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedItems: Set<String>
    let allItems: [String]
    let title: String

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(allItems, id: \.self) { item in
                                Button(action: {
                                    if selectedItems.contains(item) {
                                        selectedItems.remove(item)
                                    } else {
                                        selectedItems.insert(item)
                                    }
                                }) {
                                    HStack {
                                        Text(item)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if selectedItems.contains(item) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .padding()
                                }
                                .background(Color.white)
                            }
                        }
                    }
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresented = false
                            }
                            .fontWeight(.semibold)
                        }
                    }
                }
            }
    }
}

extension View {
    func specialtyMenu(isPresented: Binding<Bool>, selectedItems: Binding<Set<String>>, allItems: [String], title: String) -> some View {
        self.modifier(SpecialtyMenu(isPresented: isPresented, selectedItems: selectedItems, allItems: allItems, title: title))
    }
}
