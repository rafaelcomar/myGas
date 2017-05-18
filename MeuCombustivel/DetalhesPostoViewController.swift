//
//  DetalhesPostoViewController.swift
//  MeuCombustivel
//
//  Created by alunor17 on 28/04/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit
import Firebase

protocol DetalhesPostoViewControllerDelegate {
    func novoPosto(posto:Posto) -> Void
    func editarPosto(posto:Posto) -> Void
}

class DetalhesPostoViewController: UIViewController {

    @IBOutlet weak var nomeTxtField: UITextField!
    @IBOutlet weak var enderecoTxtField: UITextField!
    @IBOutlet weak var precoTxtField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
    @IBOutlet weak var longitudeTxtField: UITextField!
    
    var posto: Posto?
    var delegate:DetalhesPostoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  let editarPosto = posto {
            self.nomeTxtField.text = editarPosto.nome
            self.enderecoTxtField.text = editarPosto.endereco
            self.precoTxtField.text = editarPosto.preco
            self.latitudeTxtField.text = editarPosto.latitude
            self.longitudeTxtField.text = editarPosto.longitude
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSalvar(_ sender: UIButton) {
        if let _ = self.posto { //Editar
            self.posto!.nome = self.nomeTxtField.text!
            self.posto!.endereco = self.enderecoTxtField.text!
            self.posto!.preco = self.precoTxtField.text!
            self.posto!.latitude = self.latitudeTxtField.text!
            self.posto!.longitude = self.longitudeTxtField.text!
            
            //self.performSegue(withIdentifier: "Editar", sender: sender)
            self.delegate?.editarPosto(posto: self.posto!)
        } else {
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let myString = formatter.string(from: Date())
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-mm-yyyy HH:mm:ss"
            // again convert your date to string
            let dataFormatada = formatter.string(from: yourDate!)
            
            self.posto = Posto(nome: nomeTxtField.text!, endereco: enderecoTxtField.text!, preco: precoTxtField.text!, latitude: latitudeTxtField.text! , longitude:longitudeTxtField.text! , dataAtualizacao: String(describing: Date()), dataFormatada: dataFormatada , favorito: false, ref: nil)
            
            self.delegate?.novoPosto(posto: self.posto!)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    



    
}
