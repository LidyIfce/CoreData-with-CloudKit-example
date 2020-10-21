//
//  DespesasTableViewCell.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
import CoreData

class TransacoesTableViewCell: UITableViewCell {
    var transacao: Transacao? {
        didSet {
            configureCell()
        }
    }
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var status: UIButton!
    
    @IBAction func atualizarStatus(_ sender: Any) {
    }
    
    static let reuseIdentifier = "TransacoesTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 8
    }
    
    func configureCell() {
        if let transacao = transacao {
            self.valor.text = transacao.valor.description
            self.descricao.text = transacao.descricao
            self.status.tintColor = transacao.status ? UIColor.systemGreen : UIColor.red
            switch transacao.transacaoType {
            case .despesa:
                wrapperView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.50)
            case .receita:
                wrapperView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.50)
            default:
                break
            }
           
        }
    }

}
