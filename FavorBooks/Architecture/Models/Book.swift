//
//  BookFormTableViewController.swift
//  FavBooks
//
//  Created by Nune Melikyan on 13.09.22.
//

import Foundation

struct Book: CustomStringConvertible, Codable {
  let title: String
  let author: String
  let genre: String
  let length: String

  var description: String {
    return "\(title) is written by \(author) in the \(genre) genre and is \(length) pages long"
  }

  // MARK: - Persistence
  private static var documentsDirectory: URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }

  private static var archiveUrl: URL {
    documentsDirectory.appendingPathComponent("fav_books").appendingPathExtension("plist")
  }

  static func loadFromFile() -> [Book]? {

    // Load books data from the disk and assign it to the books property
    let propertyListDecoder = PropertyListDecoder()

    if let retreivedBooksData = try? Data(contentsOf: archiveUrl) {
      if let decodedBooks = try? propertyListDecoder.decode(
        Array<Book>.self, from: retreivedBooksData)
      {
        return decodedBooks
      }
    }
    return nil
  }

  static func saveToFile(_ books: [Book]) {

    let propertyListEncoder = PropertyListEncoder()
    if let encodedBooks = try? propertyListEncoder.encode(books) {
      try? encodedBooks.write(to: archiveUrl, options: .noFileProtection)
    }
  }
}
