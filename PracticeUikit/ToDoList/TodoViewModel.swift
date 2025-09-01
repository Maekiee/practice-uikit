import Foundation
import RxSwift
import RxCocoa

final class TodoViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let inputButtonTapped: ControlEvent<Void>
        let inputText: ControlProperty<String>
    }
    
    struct Output {
        let todoList: BehaviorRelay<[Todo]>
    }
    
    func transform(input: Input) -> Output {
        let loadData = UserDefaultManager.shared.todoList
        let copyTodoList = BehaviorRelay<[Todo]>(value: loadData)
        
        input.inputButtonTapped
            .withLatestFrom(input.inputText)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                var list = copyTodoList.value
                let todo = Todo(id: UUID(), title: value, isCompleted: false)
                
                list.insert(todo, at: 0)
                UserDefaultManager.shared.todoList = list
                copyTodoList.accept(list)
            }.disposed(by: disposeBag)
        
        
        
        
        return Output(todoList: copyTodoList)
    }
}
