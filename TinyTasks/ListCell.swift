//
//  ListCell.swift
//  TinyTasks
//
//  Created by Yury Potapov on 18.08.2022.
//

import SwiftUI

struct ListCell: View {
    @Environment(\.editMode) private var editMode
    @Binding var list: TaskList

    var body: some View {
        ZStack {
            if editMode?.wrappedValue == EditMode.active {
                TextEditor(
                    text: Binding<String>(
                        get: { list.name },
                        set: { newName in list = list.copy(name: newName) }
                    )
                )
                .foregroundColor(.red)
            } else {
                NavigationLink {
                    TaskListView(taskList: $list)
                        .navigationTitle(list.name)
                } label: {
                    Text(list.name)
                }
            }
        }
    }
}
