import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageUrl: String?
    let episodeIds: [Int]
    let locationName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case imageUrl = "image"
        case episodeIds = "episode"
        case locationName = "location"
    }
}
