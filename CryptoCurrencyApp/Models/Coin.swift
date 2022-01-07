import Foundation

struct Coin: Decodable {
  let id: String
  let name: String
  let symbol: String
  let rank: Int
  let is_new: Bool
  let is_active: Bool
  let type: String
}
