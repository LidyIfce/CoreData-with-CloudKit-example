//
//  TransacoesExtension.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import UIKit
extension TransacoesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transacoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransacoesTableViewCell.reuseIdentifier) as? TransacoesTableViewCell else { return UITableViewCell() }
        cell.transacao = transacoes[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NovaTransacao", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(identifier: "novatransacao") as? NovaTransacaoViewController else { fatalError() }
        viewC.modalPresentationStyle = .fullScreen
        viewC.transacao = transacoes[indexPath.row]
        viewC.delegate = self
        viewC.context = context
        present(viewC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let transacaoToRemove = transacoes [indexPath.row]
            self.context.delete(transacaoToRemove)

            TransacaoService.shared.save(context: context)
            fetchTransacoes()
        }
    }
    
    
}
