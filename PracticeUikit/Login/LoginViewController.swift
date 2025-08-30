import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    private let idTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디를 입력해 주세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let idValidateStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 11)
        label.text = "아이디 유효성 검사 테스트 텍스트"
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀전호를 입력해주세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let passwordValidateStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 11)
        label.text = "비밀번호 유효성 검사 테스트 텍스트"
        return label
    }()
    
    private let loginButton: CustomButton = CustomButton(title: "로그인")
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        
        bind()
        
    }
    
    private func bind() {
            
        let input = LoginViewModel.Input(
            idTextValue: idTextField.rx.text.orEmpty,
            passwordTextValue: passwordTextField.rx.text.orEmpty,
            loginButtonTapped: loginButton.rx.tap
        )
        
        
        
        let output = viewModel.transform(input: input)
        
        
        
    }

}


extension LoginViewController: UIConfigureViewController {
    func configHierarchy() {
        [
            idTextField,
            idValidateStateLabel,
            passwordTextField,
            passwordValidateStateLabel,
            loginButton
            
        ].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        idValidateStateLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(2)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(44)
        }
        
        
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idValidateStateLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        passwordValidateStateLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(44)
        }
        
        
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidateStateLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
//        signupButton.snp.makeConstraints { make in
//            make.top.equalTo(loginButton.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().inset(40)
//            make.height.equalTo(40)
//        }
        
        
    }
    
    func configView() {
        view.backgroundColor = .white
    }
    
    
}


