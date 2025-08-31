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
        let idValidState: BehaviorRelay<Bool>
        let passwordValidState: BehaviorRelay<Bool>
        let buttonEnabled: BehaviorRelay<Bool>
        let isChangeRootView: BehaviorRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let idValidState = BehaviorRelay<Bool>(value: true)
        let passwordValidState = BehaviorRelay<Bool>(value: true)
        let buttonEnabled = BehaviorRelay<Bool>(value: false)
        let isChangeRootView = BehaviorRelay<Bool>(value: false)
        
        let idValid = input.idTextValue
            .skip(2)
            .map { $0.count > 2 && $0.count < 15 }
            .share(replay: 1)
        
        let passwordValid = input.passwordTextValue
            .skip(2)
            .map { $0.count > 8 }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(idValid, passwordValid) { $0 && $1 }.share(replay: 1)
        
        input.loginButtonTapped
            .withLatestFrom(everythingValid)
            .bind(with: self) { owner, value in
                isChangeRootView.accept(value)
            }.disposed(by: disposeBag)
        
        idValid.bind(with: self) { owner, value in
            idValidState.accept(value)
        }.disposed(by: disposeBag)
        
        passwordValid.bind(with: self) { owner, value in
            passwordValidState.accept(value)
        }.disposed(by: disposeBag)
        
        everythingValid.bind(with: self) { owner, value in
            buttonEnabled.accept(value)
        }.disposed(by: disposeBag)
        
        return Output(
            idValidState: idValidState,
            passwordValidState: passwordValidState,
            buttonEnabled: buttonEnabled,
            isChangeRootView: isChangeRootView)
    }
    
}
