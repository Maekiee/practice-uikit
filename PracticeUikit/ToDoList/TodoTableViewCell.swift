import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TodoTableViewCell: UITableViewCell {
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    let todoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    let checkButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        configView()
        
        bind()
    }
    
    private func bind() {
//        checkButton.rx.tap
//            .bind(with: self) { owner, value in
//                
//                owner.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
//            }.disposed(by: disposeBag)
    }
    
    func setData(_ row: Int, _ rowData: Todo) {
        numberLabel.text = "\(row+1)"
        todoLabel.text = rowData.title
        checkButton.setImage(UIImage(systemName: rowData.isCompleted ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoTableViewCell: UIConfigureViewController {
    func configHierarchy() {
        [
            numberLabel,
            todoLabel,
            checkButton
        ].forEach { contentView.addSubview($0) }
    }
    
    func configLayout() {
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        todoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configView() {
    }
    
    
}
