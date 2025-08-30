import UIKit
import SnapKit


class TodoListViewController: UIViewController {
    
    let searchBar = UISearchBar()
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()

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
