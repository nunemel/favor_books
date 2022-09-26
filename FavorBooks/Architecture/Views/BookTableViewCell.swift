//
//  BookTableViewCell.swift
//  FavBooks
//
//  Created by Nune Melikyan on 14.09.22.
//

import UIKit

final class BookTableViewCell: UITableViewCell {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var authorLabel: UILabel!
  @IBOutlet private weak var genreLabel: UILabel!
  @IBOutlet private weak var lengthLabel: UILabel!

  public func update(with book: Book) {
    titleLabel.text = book.title
    authorLabel.text = book.author
    genreLabel.text = book.genre
    lengthLabel.text = book.length
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(
      by: UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 0))
  }
}
