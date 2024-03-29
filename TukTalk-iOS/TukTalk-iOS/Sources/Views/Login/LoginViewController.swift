//
//  LoginViewController.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/15.
//

import RxSwift
import RxCocoa
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let tempLogo = UILabel().then {
        $0.text = "로고 들어갈 곳"
        $0.textColor = UIColor.Primary.primary
        $0.font = UIFont.TTFont(type: .SDBold, size: 34)
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "아이디(이메일)"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let errorIcon = UIImageView().then {
        $0.image = UIImage(named: "errorIcon")
        $0.isHidden = true
    }
    
    private let emailErrorMsg = UILabel().then {
        $0.text = "이메일 형식이 유효하지 않습니다."
        $0.textColor = UIColor.State.error
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.isHidden = true
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.font = UIFont.TTFont(type: .SDReg, size: 15)
        $0.setUnderline(false)
    }
    
    private let passwordErrorMsg = UILabel().then {
        $0.text = "비밀번호가 맞지 않습니다."
        $0.textColor = UIColor.State.error
        $0.font = UIFont.TTFont(type: .SDReg, size: 10)
        $0.isHidden = true
    }
    
    private let loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor.Primary.primary
        $0.layer.cornerRadius = 26
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 16)
    }
    
    private let findBtn = UIButton().then {
        $0.setTitle("아이디 | 비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 13)
        $0.setTitleColor(UIColor.GrayScale.sub3, for: .normal)
    }
    
    private let signUpLabel = UILabel().then {
        $0.text = "아직 뚝딱 회원이 아니신가요?"
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    private let signUpBtn = UIButton().then {
        $0.titleLabel?.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.setTitleColor(UIColor.Primary.primary, for: .normal)
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        [emailTextField, passwordTextField].forEach { $0.text = ""}
    }
    
    //MARK:- Functions
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(tempLogo)
        tempLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(214)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(291)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        view.addSubview(errorIcon)
        errorIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(324)
        }
        
        view.addSubview(emailErrorMsg)
        emailErrorMsg.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(46)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        view.addSubview(passwordErrorMsg)
        passwordErrorMsg.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.equalToSuperview().offset(77)
        }
        
        view.addSubview(signUpBtn)
        let attribute = NSMutableAttributedString(string: "회원가입")
        attribute.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: 4))
        signUpBtn.setAttributedTitle(attribute, for: .normal)
        signUpBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.leading.equalTo(signUpLabel.snp.trailing).offset(8)
        }
        
        view.addSubview(findBtn)
        findBtn.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }

    
    private func binding() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.input.emailText)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.input.passwordText)
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .bind(onNext: { _ in
                self.emailTextField.setUnderline(true)
            })
            .disposed(by: disposeBag)

        emailTextField.rx.controlEvent(.editingDidEnd)
            .bind(onNext: { _ in
                self.emailTextField.setUnderline(false)
                self.loginViewModel.output.emailIsValid.take(1)
                    .filter {!$0}
                    .bind(onNext: { _ in
                        self.emailErrorMsg.isHidden = false
                        self.errorIcon.isHidden = false
                        self.errorIcon.snp.updateConstraints { make in
                            make.top.equalToSuperview().offset(325)
                        }
                    }).disposed(by: self.disposeBag)
                self.loginViewModel.output.emailIsValid.take(1)
                    .filter {$0}
                    .bind(onNext: { _ in
                        self.emailErrorMsg.isHidden = true
                        self.errorIcon.isHidden = true
                    }).disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .bind(onNext: { _ in
                self.passwordTextField.setUnderline(true)
            })
            .disposed(by: disposeBag)

        passwordTextField.rx.controlEvent(.editingDidEnd)
            .bind(onNext: { _ in
                self.passwordTextField.setUnderline(false)
            })
            .disposed(by: disposeBag)
        
        signUpBtn.rx.tap
            .bind {
                let nextVC = SignUpChoiceViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }

}
