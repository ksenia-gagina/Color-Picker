//
//  MainScreenViewController.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 18.12.2024.

import UIKit

final class MainScreenViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Private propertes
  
  private let moduleView = MainScreenView()
  
  
  // MARK: - Internal functions
  
  override func loadView() {
    super.loadView()
    
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moduleView.textFieldChange = { [weak self] textField, range, string in
      guard self != nil else { return false }
      
      let newText = (textField.text ?? "") + string
      if newText.count > 3 {
        return false
      }
      if let number = Int(newText), number <= Int(Constants.maximumValue) {
        return true
      }
      return false
    }
    
  }
  
  //MARK: - UITextFieldDelegate
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    return moduleView.textFieldChange? (textField, range, string) ?? true
  }
}
//MARK: - Constants

private enum Constants {
  static let screenWithFinalColorViewHeight: CGFloat = 100
  static let screenWithFinalColorViewLeadingTrailingConstant: CGFloat = 30
  static let screenWithFinalColorViewTop: CGFloat = 180
  static let commonStackWithFunctionalityTop: CGFloat = 20
  static let commonStackWithFunctionalityLeadingTrailingConstant: CGFloat = 25
  static let commonStackWithFunctionalityBottom: CGFloat = 100
  static let screenWithFinalColorViewCornerRadius: CGFloat = 45
  static let screenWithFinalColorViewBorderWidth: CGFloat = 2
  static let verticalStackSliderSpacing: CGFloat = 20
  static let verticalStackLabelTextFieldSpacing: CGFloat = 25
  static let commonStackWithFunctionalitySpacing: CGFloat = 20
  static let minimumValue: CGFloat = 0
  static let maximumValue: CGFloat = 255
  static let alphaBackgroundColor: CGFloat = 1.0
  static let alphaComponentBackgroundColor: CGFloat = 0.5
}

