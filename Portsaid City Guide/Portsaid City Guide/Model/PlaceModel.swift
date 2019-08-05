
import Foundation

struct PlaceModel: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let geometry: Geometry?
    let icon: String?
    let id, name: String?
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let rating: Double?
    let userRatingsTotal: Double?
    let vicinity: String?
    
    enum CodingKeys: String, CodingKey {
        case geometry, icon, id, name
        case openingHours = "opening_hours"
        case photos
        case rating
        case userRatingsTotal = "user_ratings_total"
        case vicinity
    }
}

struct Geometry: Codable {
    let location: Location?
}

struct Location: Codable {
    let lat, lng: Double?
}
struct OpeningHours: Codable {
    let openNow: Bool?
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

struct Photo: Codable {
    let height, width: Int?
}

struct PlusCode: Codable {
    let compoundCode, globalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}
