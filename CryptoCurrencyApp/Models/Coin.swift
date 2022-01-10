import Foundation

struct Coin: Decodable {
  let id: String
  let name: String
  let symbol: String
  let rank: Int
  let isNew: Bool
  let isActive: Bool
  let type: String
}
