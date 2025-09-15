import UIKit
import SnapKit

struct Product: Hashable {
    let name: String
    let price: Int
    let uploadDate: String
}


class WishListViewController: UIViewController {
 
    enum Section: CaseIterable {
        case main
    }
    
    private let searchBar = UISearchBar()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    let list = [
        Product(name: "Lofree flow2", price: 199000, uploadDate: "25.08.22"),
        Product(name: "프레임바이 듀얼 스탠드", price: 88000, uploadDate: "25.09.02"),
        Product(name: "샤오미 공기청정기", price: 230000, uploadDate: "24.02.22"),
        Product(name: "알루미늄 2단 접이식 거치대", price: 199000, uploadDate: "25.04.01"),
        Product(name: "냉동 삼겹살 1kg", price: 23000, uploadDate: "25.07.15"),
        Product(name: "물티슈", price: 15000, uploadDate: "25.08.30"),
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        configDataSource()
        updateSnapshot()
    }
    
    private func configDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Product>!
        
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .blue
            content.textProperties.font = .boldSystemFont(ofSize: 17)
            content.secondaryText = itemIdentifier.price.formatted() + "원"
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
