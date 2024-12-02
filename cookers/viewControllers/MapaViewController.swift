import UIKit
import MapKit 
import CoreLocation

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

       override func viewDidLoad() {
           super.viewDidLoad()

           // Configurar el mapa
           mapView.showsUserLocation = true
           mapView.mapType = .standard // Establecer tipo de mapa estándar

           // Solicitar permisos de ubicación
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.requestAlwaysAuthorization() // Si también necesitas acceso en segundo plano

           // Comenzar a actualizar la ubicación
           if CLLocationManager.locationServicesEnabled() {
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()
           } else {
               print("Los servicios de ubicación no están habilitados.")
           }
       }

       // Delegate method para actualizar la ubicación del usuario
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.first {
               // Si quieres simular que la ubicación es TECSUP, ajusta las coordenadas aquí
               let tecsupLocation = CLLocation(latitude: -16.395238, longitude: -71.537374)
               
               // Imprimir la ubicación exacta para depuración
               print("Ubicación exacta: \(tecsupLocation.coordinate.latitude), \(tecsupLocation.coordinate.longitude)")
               
               // Configurar la región del mapa usando las coordenadas simuladas de TECSUP
               let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Ajuste fino
               let region = MKCoordinateRegion(center: tecsupLocation.coordinate, span: span)
               mapView.setRegion(region, animated: true)

               // Crear y agregar un marcador en la ubicación de TECSUP (simulada)
               let annotation = MKPointAnnotation()
               annotation.coordinate = tecsupLocation.coordinate
               annotation.title = "TECSUP Arequipa"
               mapView.addAnnotation(annotation)
           }
       }

       // Delegate method para manejar errores de ubicación
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           if let locationError = error as? CLError {
               switch locationError.code {
               case .denied:
                   print("Acceso denegado a la ubicación. Verifica los permisos en Configuración.")
               case .locationUnknown:
                   print("No se pudo determinar la ubicación actual.")
               case .network:
                   print("Hubo un error de red al obtener la ubicación.")
               default:
                   print("Error desconocido al obtener la ubicación: \(error.localizedDescription)")
               }
           } else {
               print("Error al obtener la ubicación: \(error.localizedDescription)")
           }
       }
   }
