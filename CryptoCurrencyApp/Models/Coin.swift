import Foundation

struct Coin: Decodable {
  var label: String {
    "\(rank). \(name) (\(symbol))"
  }
  var status: String {
    isActive ? "active" : "not active"
  }
  
  let id: String
  let name: String
  let symbol: String
  let rank: Int
  let isNew: Bool
  let isActive: Bool
  let type: String
  
}
