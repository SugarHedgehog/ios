import Foundation
import UIKit

class ApiService {
    static let shared = ApiService()

    private let baseUrl = "https://rickandmortyapi.com/api"

    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        let url = "\(baseUrl)/character?page=1&limit=20"
        fetchData(from: url, completion: completion)
    }

    func fetchImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }

    private func fetchData<T: Codable>(from url: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(decodedData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
