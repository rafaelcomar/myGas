//
//  Posto.swift
//  MeuCombustivel
//
//  Created by alunor17 on 28/04/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import Foundation
import Firebase

struct Posto {
    var nome:String
    var endereco:String
    var preco:String
    var latitude:String
    var longitude:String
    var dataAtualizacao: String
    var dataFormatada: String
    var favorito:Bool
    var ref: FIRDatabaseReference?
    func toAnyObject() -> Any {
        return ["nome":nome, "endereco":endereco, "preco":preco , "latitude":latitude , "longitude":longitude , "dataAtualizacao": dataAtualizacao, "dataFormatada" : dataFormatada  ,"favorito":favorito]
    }
}
