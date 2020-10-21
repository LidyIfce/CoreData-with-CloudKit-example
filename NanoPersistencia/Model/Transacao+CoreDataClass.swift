//
//  Transacao+CoreDataClass.swift
//  NanoPersistencia
//
//  Created by Lidiane Gomes Barbosa on 15/10/20.
//
//

import Foundation
import CoreData
enum TransacaoType: String {
    case todas = "todas", receita = "receita", despesa = "despesa"
}
@objc(Transacao)
public class Transacao: NSManagedObject {
    var transacaoType: TransacaoType {
        set {
            self.tipo = newValue.rawValue
        }
        get {
            return TransacaoType(rawValue: self.tipo ?? "receita") ?? .receita
        }
    }
}
