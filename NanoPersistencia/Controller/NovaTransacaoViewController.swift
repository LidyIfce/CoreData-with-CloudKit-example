//
//  NovaTransacaoViewController.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import UIKit
import CoreData
class NovaTransacaoViewController: UIViewController, UIActionSheetDelegate {
    
    var amt = 0
    var transacao: Transacao?
    var context: NSManagedObjectContext!
    
    weak var delegate: TransacoesDelegate?
    @IBOutlet weak var buttonTipoTransacao: UIButton!
    
    @IBOutlet weak var buttonDeletar: UIButton!
    
    @IBOutlet weak var valor: UITextField!
    
    @IBOutlet weak var descricao: UITextField!
    
    @IBOutlet weak var buttonSwitch: UISwitch!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    @IBOutlet weak var buttonSalvar: UIButton!
    
    var transacaoType: TransacaoType = .receita {
        didSet {
            switch transacaoType {
            case .despesa:
                self.buttonTipoTransacao.layer.backgroundColor = UIColor.red.cgColor
                self.buttonTipoTransacao.setTitle("Despesa", for: .normal)
                self.labelStatus.text = buttonSwitch.isOn ? "Pago" : "Não foi pago"
                self.buttonSalvar.backgroundColor = UIColor.red
            case .receita:
                self.buttonTipoTransacao.layer.backgroundColor = UIColor.systemGreen.cgColor
                self.buttonTipoTransacao.setTitle("Receita", for: .normal)
                self.labelStatus.text = buttonSwitch.isOn ? "Recebido" : "Não foi recebido"
                self.buttonSalvar.backgroundColor = UIColor.systemGreen
            case .todas: break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonTipoTransicao()
        configureButtonSalvar()
        configureTextFields()
        configureValoresParaModoEditar()
    
        if transacao == nil {
            buttonDeletar.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletarTransacao(_ sender: Any) {
        if let transacao = transacao {
            self.context.delete(transacao)
            
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
            delegate?.didRemove()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func alternarTransacao(_ sender: Any) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let despesa = UIAlertAction(title: "Despesa", style: .default, handler: { _ in
            self.transacaoType = .despesa
        })
        let receita = UIAlertAction(title: "Receita", style: .default, handler: { _ in
            self.transacaoType = .receita
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        menu.addAction(despesa)
        menu.addAction(receita)
        menu.addAction(cancelAction)
        
        
        present(menu, animated: true, completion: nil)
        
        menu.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
        
    }
    
    @IBAction func switchStatus(_ sender: UISwitch) {
        switch transacaoType {
        case .despesa:
            self.labelStatus.text = sender.isOn ? "Pago" : "Não foi pago"
        case .receita:
            self.labelStatus.text = sender.isOn ? "Recebido" : "Não foi recebido"
        case .todas:
            break
        }
    }
    
    @IBAction func salvar(_ sender: Any) {
        if transacao != nil {
            updateTransacao()
        } else {
            createTransacao()
        }
        
        TransacaoService.shared.save(context: context)
        self.dismiss(animated: true, completion: nil)
    
    }
    func createTransacao() {
        guard let valorStr = valor.text else { return }
        let valor = NSString(string: valorStr).doubleValue
        guard let descricao = descricao.text else { return }
        let status = buttonSwitch.isOn
        
        let newTransacao = Transacao(context: self.context)
        newTransacao.id = UUID()
        newTransacao.data = Date()
        newTransacao.valor = valor
        newTransacao.descricao = descricao
        newTransacao.status = status
        newTransacao.transacaoType = self.transacaoType
    }
    
    func updateTransacao() {
        guard let valorStr = valor.text else { return }
        let valor = NSString(string: valorStr).doubleValue
        guard let descricao = descricao.text else { return }
        let status = buttonSwitch.isOn
        
        if let transacao = transacao {
            transacao.valor = valor
            transacao.descricao = descricao
            transacao.status = status
            transacao.transacaoType = self.transacaoType
        }
    }
    
    func configureValoresParaModoEditar() {
        if let transacao = transacao {
            self.descricao.text = transacao.descricao
            self.valor.text = transacao.valor.description
            self.buttonSwitch.isOn = transacao.status
            self.transacaoType = transacao.transacaoType
        }
    }
    
    func configureTextFields() {
        valor.keyboardType = .decimalPad
        valor.delegate = self
        descricao.keyboardType = .default
        descricao.delegate = self
        valor.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        descricao.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone(sender: UITextView) {
        view.endEditing(true)
    }
    
    func configureButtonTipoTransicao() {
        buttonTipoTransacao.layer.backgroundColor = UIColor.systemGreen.cgColor
        buttonTipoTransacao.setTitle("Receita", for: .normal)
        buttonTipoTransacao.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        buttonTipoTransacao.titleLabel?.textAlignment = .center
        buttonTipoTransacao.titleLabel?.textColor = .white
        buttonTipoTransacao.titleLabel?.tintColor = .white
        buttonTipoTransacao.layer.cornerRadius = 5
        buttonTipoTransacao.layer.masksToBounds = true
        
        buttonTipoTransacao.translatesAutoresizingMaskIntoConstraints = false
        buttonTipoTransacao.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonTipoTransacao.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    func configureButtonSalvar() {
        buttonSalvar.layer.backgroundColor = UIColor.systemGreen.cgColor
        buttonSalvar.layer.cornerRadius = 5
        buttonSalvar.layer.masksToBounds = true
    }
    
}

extension NovaTransacaoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == valor {
            if let digit = Int(string) {
                amt = amt * 10 + digit
                valor.text = updateTextFieldValue()
            }
            
            if string == "" {
                amt = amt / 10
                valor.text = updateTextFieldValue()
            }
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == descricao {
            valor.resignFirstResponder()
            print("desc")
        }
        if textField == valor {
            descricao.resignFirstResponder()
            print("valor")
        }
    }
    
    func updateTextFieldValue() -> String? {
        let number = Double(amt/100) + Double(amt % 100) / 100
        return String(number)
    }
}
