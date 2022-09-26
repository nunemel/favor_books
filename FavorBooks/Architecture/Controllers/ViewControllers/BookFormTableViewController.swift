//
//  BookFormTableViewController.swift
//  FavBooks
//
//  Created by Nune Melikyan on 13.09.22.
//

import UIKit

final class BookFormTableViewController: UITableViewController {

  var book: Book?

  @IBOutlet weak private var titleTextField: UITextField!
  @IBOutlet weak private var authorTextField: UITextField!
  @IBOutlet weak private var genreTextField: UITextField!
  @IBOutlet weak private var lengthTextField: UITextField!
  @IBOutlet weak private var titlErrorLabel: UILabel!
  @IBOutlet weak private var authorErrorLabel: UILabel!
  @IBOutlet weak private var genreErrorLabel: UILabel!
  @IBOutlet weak private var lengthErrorLabel: UILabel!
  @IBOutlet weak private var saveButton: UIButton!

  // MARK: - Initialization
  init?(
    coder: NSCoder,
    book: Book?
  ) {
    self.book = book
    super.init(coder: coder)
  }

  required init?(
    coder: NSCoder
  ) {
    self.book = nil
    super.init(coder: coder)
  }

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    updateView()
    checkForValidForm()
  }

  // MARK: - Validation
  func checkForValidForm() {

    if titlErrorLabel.text == "Required" && !titleTextField.text!.isEmptyOrWhitespace()
      && authorErrorLabel.text == "Required" && !authorTextField.text!.isEmptyOrWhitespace()
      && genreErrorLabel.text == "Required" && !genreTextField.text!.isEmptyOrWhitespace()
      && lengthErrorLabel.text == "Required" && !lengthTextField.text!.isEmptyOrWhitespace()
    {
      saveButton.isEnabled = true
    }
    else {

      saveButton.isEnabled = false
    }

  }

  private func invalidTitle(_ value: String) -> String? {

    let trimmedValue = value.trimmingCharacters(in: .whitespaces)

    if trimmedValue.isEmptyOrWhitespace() {
      return "Title is required."
    }

    if trimmedValue.count >= 60 {
      return "Title length must not exceed 10 characters."
    }

    return nil
  }

  private func invalidAuthor(_ value: String) -> String? {

    let trimmedValue = value.trimmingCharacters(in: .whitespaces)

    if trimmedValue.isEmpty {
      return "Author is required."
    }

    if trimmedValue.count >= 60 {
      return "Author length must not exceed 10 characters."
    }

    return nil
  }

  private func invalidGenre(_ value: String) -> String? {

    let trimmedValue = value.trimmingCharacters(in: .whitespaces)

    if trimmedValue.isEmptyOrWhitespace() {
      return "Genre is required."
    }

    if trimmedValue.count >= 60 {
      return "Genre length must not exceed 20 characters."
    }

    return nil
  }

  private func invalidLength(_ value: String) -> String? {

    let trimmedValue = value.trimmingCharacters(in: .whitespaces)

    if trimmedValue.isEmpty {
      return "Length is required."
    }

    let set = CharacterSet(charactersIn: trimmedValue)
    if !CharacterSet.decimalDigits.isSuperset(of: set) {
      return "Length must contain only digits."
    }

    if trimmedValue.count >= 60 {
      return "Length must not exceed 10 characters."
    }

    return nil
  }

  // MARK: - textfield changed actions
  @IBAction private func titleChanged(_ sender: UITextField) {
    if let title = titleTextField.text {
      if let errorMessage = invalidTitle(title) {
        titlErrorLabel.text = errorMessage
      }
      else {
        titlErrorLabel.text = "Required"
      }
    }
    checkForValidForm()
  }

  @IBAction private func authorChanged(_ sender: UITextField) {
    if let author = authorTextField.text {
      if let errorMessage = invalidAuthor(author) {
        authorErrorLabel.text = errorMessage
      }
      else {
        authorErrorLabel.text = "Required"
      }
    }
    checkForValidForm()
  }

  @IBAction private func genreChanged(_ sender: UITextField) {
    if let genre = genreTextField.text {

      if let errorMessage = invalidGenre(genre) {
        genreErrorLabel.text = errorMessage
      }
      else {
        genreErrorLabel.text = "Required"
      }
    }
    checkForValidForm()
  }

  @IBAction private func lengthChanged(_ sender: UITextField) {
    if let length = lengthTextField.text {
      if let errorMessage = invalidLength(length) {
        lengthErrorLabel.text = errorMessage
      }
      else {
        lengthErrorLabel.text = "Required"
      }
    }
    checkForValidForm()
  }

  private func updateView() {
    guard let book = book else { return }

    saveButton.isEnabled = false
    titleTextField.text = book.title
    authorTextField.text = book.author
    genreTextField.text = book.genre
    lengthTextField.text = book.length
  }

  @IBAction private func saveButtonTapped(_ sender: Any) {
    guard let title = titleTextField.text?.trimmingCharacters(in: .whitespaces),
      let author = authorTextField.text?.trimmingCharacters(in: .whitespaces),
      let genre = genreTextField.text?.trimmingCharacters(in: .whitespaces),
      let length = lengthTextField.text?.trimmingCharacters(in: .whitespaces)
    else { return }

    book = Book(title: title, author: author, genre: genre, length: length)
    performSegue(withIdentifier: "UnwindToBookTable", sender: self)
  }
}

// MARK: - Extension
extension String {
  func isEmptyOrWhitespace() -> Bool {

    if self.isEmpty {
      return true
    }

    return (self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "")
  }
}
