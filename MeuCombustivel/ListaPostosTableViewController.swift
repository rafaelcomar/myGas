//
//  ListaPostosTableViewController.swift
//  MeuCombustivel
//
//  Created by alunor17 on 28/04/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit
import Firebase

class ListaPostosTableViewController: UITableViewController, DetalhesPostoViewControllerDelegate {

    var ref: FIRDatabaseReference!
    
   
    var postos:[Posto] = [Posto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem = 
        ref = FIRDatabase.database().reference()
        self.setupRealtimeDatabaseEvents()
        
        
    }
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            self.present(buildAlertController(withMessage: signOutError.localizedDescription), animated: true, completion: nil)
        }
    }
    
    func setupRealtimeDatabaseEvents() -> Void {
        
        self.ref.child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of:.value, with: { (snapshot) in
            self.postos.removeAll()
            for childSnapshot in snapshot.children {
                let child = childSnapshot as! FIRDataSnapshot
                let value = child.value as! [String: Any]
                
//                let posto = Posto(nome: value["nome"] as! String, posicao: value["posicao"] as! String,camisa: value["camisa"] as! String, titular: value["titular"] as! Bool, ref:child.ref)
                let posto = Posto(nome: value["nome"] as! String, endereco: value["endereco"] as! String, preco: value["preco"] as! String, latitude: value["latitude"] as! String, longitude: value["longitude"] as! String, dataAtualizacao: value["dataAtualizacao"] as! String ,dataFormatada: value["dataFormatada"] as! String, favorito: false, ref: child.ref)
                
                self.postos.append(posto)
                self.tableView.reloadData()
            }
        })
        
        self.ref.child(FIRAuth.auth()!.currentUser!.uid).observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as! [String: Any]
            
            let posto = Posto(nome: value["nome"] as! String, endereco: value["endereco"] as! String, preco: value["preco"] as! String, latitude: value["latitude"] as! String, longitude: value["longitude"] as! String,dataAtualizacao: value["dataAtualizacao"] as! String ,dataFormatada: value["dataFormatada"] as! String,  favorito: false, ref: snapshot.ref)
            
            self.postos.append(posto)
            let indexPath = IndexPath(row: self.postos.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        })

        self.ref.child(FIRAuth.auth()!.currentUser!.uid).observe(.childChanged, with: { (snapshot) in
            let key = snapshot.key
            let updatedValue = snapshot.value as! [String:Any]
            
            for (index, posto) in self.postos.enumerated() {
                if posto.ref!.key == key {
                    self.postos[index].nome = updatedValue["nome"] as! String
                    self.postos[index].endereco = updatedValue["endereco"] as! String
                    self.postos[index].preco = updatedValue["preco"] as! String
                   
                    break;
                }
            }
            
            self.tableView.reloadData()
        })
        self.ref.child(FIRAuth.auth()!.currentUser!.uid).observe(.childRemoved, with: { (snapshot) in
            let key = snapshot.key
            
            for (index, posto) in self.postos.enumerated() {
                if posto.ref!.key == key {
                    self.postos.remove(at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    break;
                }
            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.postos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postoCell", for: indexPath) as! PostoTableViewCell
        
        let posto = self.postos[indexPath.row]
        
        cell.nomePostoLabel.text = posto.nome
        cell.precoLabel.text = posto.preco
        
        
        return cell
    }
    
    func novoPosto(posto:Posto) -> Void {
        
        self.ref.child(FIRAuth.auth()!.currentUser!.uid).childByAutoId().setValue(posto.toAnyObject())
        
        self.navigationController!.popViewController(animated: true)
    }
    
    func editarPosto(posto:Posto) -> Void {
    
        posto.ref?.setValue(posto.toAnyObject())
        self.navigationController!.popViewController(animated: true)
    }
    

    
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let posto = self.postos[indexPath.row]
            posto.ref?.removeValue()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//            let posto = self.postos[indexPath.row]
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "novoPostoSegue") {
            let dvc = segue.destination as! DetalhesPostoViewController
            dvc.delegate = self
        }else if(segue.identifier == "editarPostoSegue") {
            let dvc = segue.destination as! MapaPostoViewController
            dvc.delegate = self
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let posto = self.postos[indexPath.row]
                dvc.posto = posto
            }
            
            
        }
    }
    

}
