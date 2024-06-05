import Foundation

class ParkingLotService {
    let baseURL = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=mobilityref-france-base-nationale-des-lieux-de-stationnement"

    func fetchParkingLots(completion: @escaping (Result<ParkingDataLots, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let parkingDataResponse = try decoder.decode(ParkingDataLots.self, from: data)
                completion(.success(parkingDataResponse))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}




struct ParkingDataLots: Codable {
    let records: [ParkingData]
}

struct ParkingData: Codable {
    let id: String
    let name: String
    let address: String
    let geoPoint2D: GeoPoint
//Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "records", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0)], debugDescription: "No value associated with key CodingKeys(stringValue: \"id\", intValue: nil) (\"id\").", underlyingError: nil)
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case geoPoint2D = "geopoint2d"
    }
    
    
    
     
}

struct GeoPoint: Codable {
    let lon: Double
    let lat: Double
}

