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
//        view.rowHeight =
        view.separatorStyle = .none
        return view
    }()
    
    let list: BehaviorRelay<[String]> = BehaviorRelay(value: [
        "a","b","c","d","e","f","g","h","i","k",
    ])
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        
        bind()

    }
    
    func bind() {
        list.bind(to: tableView.rx.items(cellIdentifier: TodoTableViewCell.identifier, cellType: TodoTableViewCell.self)) {
            (row, element, cell) in
            cell.numberLabel.text = "\(row)"
            cell.todoLabel.text = element
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
