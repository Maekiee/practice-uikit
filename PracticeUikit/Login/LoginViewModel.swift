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
        let idValidateText: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        let idValidateText = PublishRelay<String>()
        let passwordValidateText = PublishRelay<String>()
        
        
        input.idTextValue
            .bind(with: self) { owner, text in
                if text.count >= 2 && text.count <= 15 {
                    
                } else {
                    var idValidateText = "아이디는 2자리 이상 15자리 이하로 입력해주세요"
                    idValidateText.append(idValidateText)
                }
            }.disposed(by: disposeBag)
        
        
        input.passwordTextValue
            .bind(with: self) { owner, text in
                if text.count > 2 && text.count <= 15 {
                    passwordValidateText.accept(text)
                } else {
                    
                }
            }.disposed(by: disposeBag)
        
        
        return Output(idValidateText: idValidateText)
    }
    
}
