//
//  MapaPostoViewController.swift
//  MeuCombustivel
//
//  Created by alunor17 on 02/05/17.
//  Copyright © 2017 Comar Ltda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapaPostoViewController: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var enderecoTxtField: UITextField!
    @IBOutlet weak var precoTxtField: UITextField!
//    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var dataHoraTxtField: UITextField!
    
    var posto: Posto!
    var delegate:DetalhesPostoViewControllerDelegate!
    var newAnnotation : MKAnnotation!
    
    private var firstZoom = false
    
    var locationManager = CLLocationManager()
    
//    func checkLocationAuthorizationStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            self.map.showsUserLocation = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        if !firstZoom {
//            let newRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
//            self.map.setRegion(newRegion, animated: true)
//        }
//    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.map.setCenter(userLocation.coordinate, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let editarPosto = posto {

            
            self.enderecoTxtField.text = editarPosto.endereco
            self.precoTxtField.text = editarPosto.preco
            self.dataHoraTxtField.text = "Atualizado as " + editarPosto.dataFormatada
            
            
            let data = editarPosto.dataAtualizacao
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: data)
            
            self.title = editarPosto.nome

            }
            locationManager.requestWhenInUseAuthorization()
        
        let posLat = Float(self.posto.latitude)
        let posLong = Float(self.posto.longitude)
        
            self.map.mapType = .standard
            self.map.showsUserLocation = true
            self.map.showsScale = true
            self.map.showsCompass = true
        

        let newRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(CLLocationDegrees(posLat! ), CLLocationDegrees(posLong!)), 2000, 2000)
        self.map.setRegion(newRegion, animated: true)
        
        
        //let postoAnnotation = Pokemon(name: pokemonName, coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(pokemonLat), CLLocationDegrees(pokemonLong)))
        
        
        let postoAnnotation = PostoAnnotation(name: self.posto.nome, coordinate: CLLocationCoordinate2DMake(CLLocationDegrees(posLat! ), CLLocationDegrees(posLong!)))
        
        self.map.addAnnotation(postoAnnotation)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//      
//            view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//           
//            return view as! MKAnnotationView?
//        
//    }
//    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) -> Void {
//        print("AAAAAAAA")
//        
//    }

}
