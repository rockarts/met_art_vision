//
//  Story.swift
//  met_art
//
//  Created by Steven Rockarts on 2024-03-24.
//

import Foundation

public struct Story: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let by: String
  public let time: TimeInterval
  public let url: String
}

extension Story: Comparable {
  public static func < (lhs: Story, rhs: Story) -> Bool {
    return lhs.time > rhs.time
  }
}

extension Story: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "\n\(title)\nby \(by)\n\(url)\n-----"
  }
}
