

import UIKit
import MapKit

class ParkingLotViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial location (e.g., Lyon)
        let initialLocation = CLLocation(latitude: 45.75, longitude: 4.85)
        let regionRadius: CLLocationDistance = 1000

        // Set up the map view
        mapView.delegate = self
        //request user permission to access location
        
        mapView.showsUserLocation = true
        
        
        
        centerMapOnLocation(location:mapView.userLocation.location ?? initialLocation , radius: regionRadius)

        // Fetch parking locations from the API
        fetchParkingLocations()
    }

    func centerMapOnLocation(location: CLLocation, radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                   latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    

    func fetchParkingLocations() {
        // Implement code to fetch data from opendatasoft
        // Parse the JSON response into Swift objects
        // Add annotations to the map view for each parking location (long, lat)
        
        
        let parkingLotService = ParkingLotService()
        parkingLotService.fetchParkingLots { (result) in
            switch result {
            case .success(let parkingDataLots):
                // Parse the JSON response into Swift objects
                
                let parkingLocations = parkingDataLots.records.map { record in
                    let name = record.name
                    let coordinates = [record.geoPoint2D.lon, record.geoPoint2D.lat]
                    return ParkingLocation(name: name, coordinates: coordinates)
                }

                // Add annotations to the map view for each parking location
                
                for parkingLocation in parkingLocations {
                    let annotation = MKPointAnnotation()
                    annotation.title = parkingLocation.name
                    annotation.coordinate = CLLocationCoordinate2D(latitude: parkingLocation.coordinates[1], longitude: parkingLocation.coordinates[0])
                    self.mapView.addAnnotation(annotation)
                }
                
            case .failure(let error):
                print("Failed to fetch parking lots: \(error)")
            }
        }
    }
    
    struct ParkingLocation {
        let name: String
        let coordinates: [Double]
    }

    
    
}

extension ParkingLotViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "ParkingAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
