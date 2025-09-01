import Foundation


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    
    var todoList: [Todo] {
        get {
            guard let todos = UserDefaults.standard.data(forKey: Keys.todos),
                  let decodedTodo = try? decoder.decode([Todo].self, from: todos) else { return [] }
            return decodedTodo
        }
        
        set {
            if let newTodos = try? encoder.encode(newValue) {
                UserDefaults.standard.set(newTodos, forKey: Keys.todos)
            }
        }
    }
    
    func updateTodoList(selectedId: UUID) {
        if let index = todoList.firstIndex(where: { selectedId == $0.id }) {
            todoList[index].isCompleted.toggle()
        }
    }
    
    
    
}
