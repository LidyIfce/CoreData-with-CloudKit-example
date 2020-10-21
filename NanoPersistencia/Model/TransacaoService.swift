//
//  Despesa.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 08/10/20.
//

import Foundation
import CoreData
struct TransacaoService {
    static let shared = TransacaoService()
    
    func fetch(context: NSManagedObjectContext, predicate: NSPredicate?) -> [Transacao] {
        var transacoes: [Transacao] = []
        do {
            let request = Transacao.fetchRequest() as NSFetchRequest<Transacao>
            if predicate != nil {
                request.predicate = predicate
            }
            transacoes = try context.fetch(request)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return transacoes
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
