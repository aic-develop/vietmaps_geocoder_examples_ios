import UIKit
import CoreLocation
import Mapbox
import MapboxGeocoder

// A Mapbox access token is required to use the Geocoding API.
// https://www.mapbox.com/help/create-api-access-token/

class ViewController: UIViewController, MGLMapViewDelegate {
    
    // MARK: - Variables

    var mapView: MGLMapView!
    var resultsLabel: UILabel!
    var geocoder: Geocoder!
    var geocodingDataTask: URLSessionDataTask?
    
    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MGLVietMapsAccessToken") as? String
        MGLAccountManager.accessToken = accessToken
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        resultsLabel = UILabel(frame: CGRect(x: 10, y: (self.navigationController?.navigationBar.frame.origin.y ?? 0) + (self.navigationController?.navigationBar.frame.size.height ?? 0) + 20, width: view.bounds.size.width - 20, height: 30))
        resultsLabel.autoresizingMask = .flexibleWidth
        resultsLabel.adjustsFontSizeToFitWidth = true
        resultsLabel.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        resultsLabel.isUserInteractionEnabled = false
        view.addSubview(resultsLabel)
        
        geocoder = Geocoder(accessToken: accessToken)
        
        let center = CLLocationCoordinate2D(latitude: 21.030994, longitude: 105.812086)

        // Optionally set a starting point.
        mapView.setCenter(center, zoomLevel: 15, direction: 0, animated: false)
    }

    // MARK: - MGLMapViewDelegate

    func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        geocodingDataTask?.cancel()
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        geocodingDataTask?.cancel()
        let options = ReverseGeocodeOptions(coordinate: mapView.centerCoordinate)
        geocodingDataTask = geocoder.getInfoLocation(options, completionHandler: { (jsonResponse, error) in
            if let json = jsonResponse {
                if let displayName = json["display_name"] as? String {
                    self.resultsLabel.text = displayName
                }
                else {
                    self.resultsLabel.text = "No Data"
                }
            }
            else {
                self.resultsLabel.text = "No Data"
            }
        })
    }

}
