//
//  MainListView.swift
//  TinyTasks
//
//  Created by Yury Potapov on 17.08.2022.
//

import SwiftUI

struct MainListView: View {
    @AppStorage("task_lists") private var lists = ListsStorage()

    var body: some View {
        NavigationView {
            List {
                ForEach($lists) { list in
                    ListCell(list: list)
                }
                .onDelete(perform: deleteLists)
                .onMove(perform: moveLists)
            }
            .toolbar {
                HStack {
                    EditButton()
                    Button(action: appendNewList) {
                        Image(systemName: "plus.rectangle")
                    }
                }
            }
            .navigationTitle("Lists")
        }
    }

    private func appendNewList() {
        lists.append(TaskList(id: UUID().uuidString, name: "New list", tasks: []))
    }

    private func deleteLists(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
    }

    private func moveLists(at offsets: IndexSet, to offset: Int) {
        lists.move(fromOffsets: offsets, toOffset: offset)
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
