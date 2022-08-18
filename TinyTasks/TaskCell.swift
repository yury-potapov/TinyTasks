//
//  TaskCell.swift
//  TinyTasks
//
//  Created by Yury Potapov on 18.08.2022.
//

import SwiftUI

struct TaskCell: View {
    @Binding private(set) var task: Task
    @Environment(\.editMode) private var editMode

    private static let feedbackGenerator = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            if editMode?.wrappedValue == EditMode.active {
                TextEditor(
                    text: Binding<String>(
                        get: { task.text },
                        set: { newText in task = task.copy(text: newText) }
                    )
                )
                .foregroundColor(.red)
            } else {
                Button {
                    task = task.toggled()
                    feedbackSuccess()
                } label: {
                    HStack(alignment: .top) {
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.completed ? .green : .yellow)
                        Text(task.text)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func feedbackSuccess() {
        Self.feedbackGenerator.notificationOccurred(.success)
    }
}

private extension Task {
    func toggled() -> Task { copy(completed: !completed) }
}
