//
//  RegistroViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var nome: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var buttonRegistrar: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func configureUI() {
        navigationController?.isNavigationBarHidden = true
        
        nome.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        email.autocorrectionType = .no
        nome.autocorrectionType = .no
        email.keyboardType = .emailAddress
        email.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        buttonRegistrar.layer.cornerRadius = 5
        buttonRegistrar.layer.masksToBounds = true
        
        password.isSecureTextEntry = true
        password.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
    
    @IBAction func registrar(_ sender: Any) {
//        guard let nome = nome.text else { return }
//        guard let email = email.text else { return }
//        guard let password = password.text else { return }
//        
       // registrar usuário
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
