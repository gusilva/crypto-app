import Foundation

enum CoinServiceError: Error {
  case network(statusCode: Int)
  case parsing
  case general(reason: String)
}

class CoinService {
  static let shared = CoinService()
  
  private let baseUrl = "https://api.coinpaprika.com/v1/coins"
  
  func fetchCoins(completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
    guard let url = URL(string: baseUrl) else {
      completion(.failure(.general(reason: "Failed to init url.")))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if
        let _ = error,
        let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode) {
        completion(.failure(.network(statusCode: response.statusCode)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.general(reason: "Failed to parse the response data.")))
        return
      }
      
      do {
        let decodedData = try JSONDecoder().decode([Coin].self, from: data)
        
        completion(.success(decodedData))
      } catch {
        completion(.failure(.parsing))
        return
      }
    }.resume()
  }
}
