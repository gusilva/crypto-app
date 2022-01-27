import Foundation

enum CoinServiceError: Error {
  case network(statusCode: Int)
  case parsing
  case general(reason: String)
}

class CoinService {
  static let shared = CoinService()
  
  private let baseUrl = "https://api.coinpaprika.com/v1/coins"
  
  func fetchCoinDetail(coinId: String, completion: @escaping (Result<CoinDetail, CoinServiceError>) -> Void) {
    fetchData(urlString: "\(baseUrl)/\(coinId)", completion: completion)
  }
  
  func fetchCoins(completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
    fetchData(urlString: baseUrl, completion: completion)
  }
  
  private func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, CoinServiceError>) -> (Void)) {
    guard let url = URL(string: urlString) else {
      completion(.failure(.general(reason: NSLocalizedString("ERROR_INIT_URL", comment: "error init url"))))
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
        completion(.failure(.general(reason: NSLocalizedString("ERROR_PARSING_DATA", comment: "parsing error"))))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(T.self, from: data)
        completion(.success(result))
        
      } catch let error {
        print(error)
        completion(.failure(.parsing))
      }
    }.resume()
  }
}
