//
//  DataStructs.swift
//  TinyTasks
//
//  Created by Yury Potapov on 17.08.2022.
//

import Foundation

struct Task: Identifiable, Codable, Equatable {
    let id: String
    let text: String
    let completed: Bool

    func copy(text: String? = nil, completed: Bool? = nil) -> Task {
        Task(id: id, text: text ?? self.text, completed: completed ?? self.completed)
    }
}

struct TaskList: Identifiable, Codable {
    let id: String
    let name: String
    let tasks: [Task]

    func copy(name: String? = nil, tasks: [Task]? = nil) -> TaskList {
        TaskList(id: id, name: name ?? self.name, tasks: tasks ?? self.tasks)
    }
}

typealias ListsStorage = [TaskList]

extension ListsStorage: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(ListsStorage.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
