//
//  BookFormTableViewController.swift
//  FavBooks
//
//  Created by Nune Melikyan on 13.09.22.
//

import UIKit

final class BookTableViewController: UITableViewController {

  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var authorLabel: UILabel!
  @IBOutlet weak private var genreLabel: UILabel!
  @IBOutlet weak private var lengthLabel: UILabel!

  var books: [Book] = []

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    books = Book.loadFromFile() ?? []
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    tableView.reloadData()
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }

  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {

    if editingStyle == .delete {
      books.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  )
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
      as! BookTableViewCell
    let book = books[indexPath.row]
    cell.update(with: book)
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    100
  }

  // MARK: - Navigation
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    guard let source = segue.source as? BookFormTableViewController,
      let book = source.book
    else { return }

    if let indexPath = tableView.indexPathForSelectedRow {
      books.remove(at: indexPath.row)
      books.insert(book, at: indexPath.row)
      tableView.deselectRow(at: indexPath, animated: true)
    }
    else {
      books.append(book)
    }

    Book.saveToFile(books)
  }

  @IBSegueAction private func editBook(
    _ coder: NSCoder,
    sender: Any?
  )
    -> BookFormTableViewController?
  {

    guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell)
    else {
      return nil
    }

    let book = books[indexPath.row]
    return BookFormTableViewController(coder: coder, book: book)
  }
}
