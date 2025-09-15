import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FirstTestViewController: UIViewController {

    
    let testLabel1: UILabel = {
        let label = UILabel()
        label.text = "테스트1"
        label.textColor = .black
        return label
    }()
    
    let testLabel2: UILabel = {
        let label = UILabel()
        label.text = "테스트2"
        label.textColor = .black
        return label
    }()
    
    let testLabel3: UILabel = {
        let label = UILabel()
        label.text = "테스트3"
        label.textColor = .black
        return label
    }()
    
    let TestButton = CustomButton(title: "다음")
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [testLabel1,testLabel2,testLabel3,TestButton].forEach { view.addSubview($0) }
        
        testLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }
        
        testLabel2.snp.makeConstraints { make in
            make.top.equalTo(testLabel1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        testLabel3.snp.makeConstraints { make in
            make.top.equalTo(testLabel2.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        TestButton.snp.makeConstraints { make in
            make.top.equalTo(testLabel3.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        bind()
    }
    
    func bind() {
        TestButton.rx.tap
            .bind(with: self) { owner, _ in
                let viewModel2 = Test2ViewModel(name: "고래밥", age: "22", weight: "60")
                let vc = SecondTestViewController(viewModel: viewModel2)
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
        
    }
    


}

