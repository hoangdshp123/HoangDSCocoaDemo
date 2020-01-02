//
//  WalletInfo.swift
//
//  Created by Hoàng Minh Thành on 1/8/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class WalletInfo: NSCoding {

  static let shared = WalletInfo.init(json: JSON.init(parseJSON: ""))
  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let listTrans = "listTrans"
    static let walletId = "walletId"
    static let balance = "balance"
    static let rewards = "rewards"
    static let tokenKey = "tokenKey"
    static let phone = "phone"
    static let point = "point"
    static let displayName = "displayName"
    static let listRewards = "listRewards"
  }

  // MARK: Properties
//  public var listTrans: [ListTransNew]?
  public var walletId: Int?
  public var balance: Int?
  public var rewards: Int?
  public var tokenKey: String?
  public var phone: String?
  public var point: Int?
  public var displayName: String?
//  public var listRewards: [ListRewardsNew]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

    func updateNewValue(newData: WalletInfo) {
        walletId = newData.walletId
        balance = newData.balance
        rewards = newData.rewards
        tokenKey = newData.tokenKey
        phone = newData.phone
        point = newData.point
        displayName = newData.displayName
//        listTrans = newData.listTrans
//        listRewards = newData.listRewards
    }
    
  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
//    if let items = json[SerializationKeys.listTrans].array { listTrans = items.map { ListTransNew(json: $0) } }
    walletId = json[SerializationKeys.walletId].int
    balance = json[SerializationKeys.balance].int
    rewards = json[SerializationKeys.rewards].int
    tokenKey = json[SerializationKeys.tokenKey].string
    phone = json[SerializationKeys.phone].string
    point = json[SerializationKeys.point].int
    displayName = json[SerializationKeys.displayName].string
//    if let items = json[SerializationKeys.listRewards].array { listRewards = items.map { ListRewardsNew(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
//    if let value = listTrans { dictionary[SerializationKeys.listTrans] = value.map { $0.dictionaryRepresentation() } }
    if let value = walletId { dictionary[SerializationKeys.walletId] = value }
    if let value = balance { dictionary[SerializationKeys.balance] = value }
    if let value = rewards { dictionary[SerializationKeys.rewards] = value }
    if let value = tokenKey { dictionary[SerializationKeys.tokenKey] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = point { dictionary[SerializationKeys.point] = value }
    if let value = displayName { dictionary[SerializationKeys.displayName] = value }
//    if let value = listRewards { dictionary[SerializationKeys.listRewards] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
//    self.listTrans = aDecoder.decodeObject(forKey: SerializationKeys.listTrans) as? [ListTransNew]
    self.walletId = aDecoder.decodeObject(forKey: SerializationKeys.walletId) as? Int
    self.balance = aDecoder.decodeObject(forKey: SerializationKeys.balance) as? Int
    self.rewards = aDecoder.decodeObject(forKey: SerializationKeys.rewards) as? Int
    self.tokenKey = aDecoder.decodeObject(forKey: SerializationKeys.tokenKey) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.point = aDecoder.decodeObject(forKey: SerializationKeys.point) as? Int
    self.displayName = aDecoder.decodeObject(forKey: SerializationKeys.displayName) as? String
//    self.listRewards = aDecoder.decodeObject(forKey: SerializationKeys.listRewards) as? [ListRewardsNew]
  }

  public func encode(with aCoder: NSCoder) {
//    aCoder.encode(listTrans, forKey: SerializationKeys.listTrans)
    aCoder.encode(walletId, forKey: SerializationKeys.walletId)
    aCoder.encode(balance, forKey: SerializationKeys.balance)
    aCoder.encode(rewards, forKey: SerializationKeys.rewards)
    aCoder.encode(tokenKey, forKey: SerializationKeys.tokenKey)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(point, forKey: SerializationKeys.point)
    aCoder.encode(displayName, forKey: SerializationKeys.displayName)
//    aCoder.encode(listRewards, forKey: SerializationKeys.listRewards)
  }

}
