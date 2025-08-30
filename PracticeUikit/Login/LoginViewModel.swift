import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let idTextValue: ControlProperty<String>
        let passwordTextValue: ControlProperty<String>
        let loginButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        let idValidateText = PublishRelay<String>()
        let passwordValidateText = PublishRelay<String>()
        
        
        input.idTextValue
            .bind(with: self) { owner, text in
                if text.count > 2 && text.count <= 15 {
                    idValidateText.accept(text)
                } else {
                    
                }
            }.disposed(by: disposeBag)
        
        
        input.passwordTextValue
            .bind(with: self) { owner, text in
                if text.count > 2 && text.count <= 15 {
                    passwordValidateText.accept(text)
                } else {
                    
                }
            }.disposed(by: disposeBag)
        
        
        return Output()
    }
    
}
