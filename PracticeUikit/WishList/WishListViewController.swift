import UIKit
import SnapKit
import RxSwift
import RxCocoa


struct Product: Hashable {
    let name: String
    let uploadDate: String
}


class WishListViewController: UIViewController {
 
    enum Section: CaseIterable {
        case main
    }
    
    private let viewModel = WishListViewModel()
    private let disposeBag = DisposeBag()
    
    private let searchBar = UISearchBar()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    var list = [
        Product(name: "Lofree flow2", uploadDate: "25.08.22"),
        Product(name: "프레임바이 듀얼 스탠드", uploadDate: "25.09.02"),
        Product(name: "샤오미 공기청정기", uploadDate: "24.02.22"),
        Product(name: "알루미늄 2단 접이식 거치대", uploadDate: "25.04.01"),
        Product(name: "냉동 삼겹살 1kg",  uploadDate: "25.07.15"),
        Product(name: "물티슈", uploadDate: "25.08.30"),
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        searchBar.delegate = self
        
        configDataSource()
        updateSnapshot()
        
        bind()
    }
    
    func bind() {
        let input = WishListViewModel.Input(
            searchBarTapped: searchBar.rx.searchButtonClicked
        )
        
        let output = viewModel.transform(input: input)
        
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                let formatter = DateFormatter()
                formatter.dateFormat = "yy.MM.dd"
                let currentDateString = formatter.string(from: Date())
                let product = Product(name: text, uploadDate: currentDateString)
                
                owner.list.insert(product, at: 0)
                owner.updateSnapshot()
                
            }.disposed(by: disposeBag)
        
    }
    
    private func configDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Product>!
        
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .blue
            content.textProperties.font = .boldSystemFont(ofSize: 17)
            content.secondaryText = itemIdentifier.uploadDate
            content.image = UIImage(systemName: "checkmark.square")
            cell.contentConfiguration = content
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}


extension WishListViewController: UISearchBarDelegate {
    
}


extension WishListViewController {
    private func setupUI() {
        view.backgroundColor = .white
         
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
 
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
