//
//  TaskListView.swift
//  TinyTasks
//
//  Created by Yury Potapov on 17.08.2022.
//

import SwiftUI

struct TaskListView: View {
    @Binding var taskList: TaskList
    @State private var updatedTasks: [Task] = []

    var body: some View {
        List {
            ForEach(Array(updatedTasks.indices), id: \.self) { index in
                TaskCell(task: $updatedTasks[index])
            }
            .onDelete(perform: deleteTasks)
            .onMove(perform: moveTasks)
        }
        .toolbar {
            HStack {
                EditButton()
                Button(action: appendNewTask) {
                    Image(systemName: "plus.rectangle")
                }
            }
        }
        .onAppear { updatedTasks = taskList.tasks }
        .onChange(of: updatedTasks) { newTasks in taskList = taskList.copy(tasks: newTasks) }
    }

    private func appendNewTask() {
        updatedTasks.append(Task(id: UUID().uuidString, text: "New task", completed: false))
    }

    private func deleteTasks(at offsets: IndexSet) {
        updatedTasks.remove(atOffsets: offsets)
    }

    private func moveTasks(at offsets: IndexSet, to offset: Int) {
        updatedTasks.move(fromOffsets: offsets, toOffset: offset)
    }
}
