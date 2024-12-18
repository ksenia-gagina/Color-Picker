//
//  MainScreenViewController.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 10.12.2024.
//

import UIKit

protocol ColorValueDelegate {
  func colorValueChanged() -> ()
}

final class MainScreenViewController: UIViewController {
  
  // MARK: - Private properties
  
  private let moduleView = MainScreenView()
  
  // MARK: - Internal functions
  
  override func loadView() {
    super.loadView()
    
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moduleView.textField = {}
    
  }
}

// MARK: - Private functions

   func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    if let text = textField.text {
      guard text.count <= 3 else {
          return false
        }
        guard Int(text) ?? .zero <= 255 else {
          return false
        }
        return true
      }
      return false
    }

    
    






