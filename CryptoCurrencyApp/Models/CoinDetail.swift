import Foundation

struct CoinDetail: Decodable {
  var status: String {
    isActive ? "active" : "not active"
  }
  let id: String
  let name: String
  let description: String?
  let symbol: String
  let rank: Int
  let isActive: Bool
  let tags: [CoinTag]?
  let team: [TeamMember]
}

struct CoinTag: Decodable {
  let coinCounter: Int
  let icoCounter: Int
  let id: String
  let name: String
}
