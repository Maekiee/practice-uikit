import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TodoListViewController: UIViewController {
    let searchBar = UISearchBar()
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.separatorStyle = .none
        return view
    }()
    
    let list: BehaviorRelay<[String]> = BehaviorRelay(value: [
        "a","b","c","d","e","f","g","h","i","k",
    ])
    
    private let disposeBag = DisposeBag()
    private let viewModel = TodoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        
        bind()

    }
    
    
    
    private func bind() {
        let input = TodoViewModel.Input(
            inputButtonTapped: searchBar.rx.searchButtonClicked,
            inputText: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.todoList.bind(to: tableView.rx.items(cellIdentifier: TodoTableViewCell.identifier, cellType: TodoTableViewCell.self)) {
            (row, element, cell) in
            cell.setData(row, element)
            cell.checkButton.rx.tap
                .bind(with: self) { owner, value in
                    if let savedData = UserDefaults.standard.data(forKey: Keys.todos) {
                        let decoder = JSONDecoder()
                        
                        
                        if var todos = try? decoder.decode([Todo].self, from: savedData) {
                            if let index = todos.firstIndex(where: { $0.id == element.id }) {
                                todos[index].isCompleted.toggle()
                            }
                            
                            
                            let encoder = JSONEncoder()
                            if let encodedData = try? encoder.encode(todos) {
                                UserDefaults.standard.set(encodedData, forKey: Keys.todos)
                            }
                            output.todoList.accept(todos)
                        }
                    }
                }.disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Todo.self)
            .bind(with: self) { owner, item in
                print(item)
            }.disposed(by: disposeBag)
    }
    
}


extension TodoListViewController: UIConfigureViewController {
    func configHierarchy() {
        [
            searchBar,
            tableView
        ].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configView() {
        navigationItem.titleView = searchBar
        view.backgroundColor = .white
        
    }
    
    
}
