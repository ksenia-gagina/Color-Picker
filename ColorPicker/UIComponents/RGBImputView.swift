//
//  RGBImputView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 03.01.2025.
//

import UIKit

public final class RGBImputView: UITextField {
  
  // MARK: - Public properties
  
  public var textFieldChange: ((Int) -> Void)?
  
  // MARK: - Init
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    setLayout()
    initial()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public funcs
  
  public func setRGB(value: Int) {
    guard value >= 0 && value <= 255 else { return }
    text = String(value)
  }
}

//MARK: - UITextFieldDelegate

extension RGBImputView: UITextFieldDelegate {
  public func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    // 1. Берём текущий текст или пустую строку, если он nil
    let currentText = textField.text ?? ""
    
    // 2. Преобразуем currentText в NSString, чтобы удобно заменить часть строки
    guard let textRange = Range(range, in: currentText) else { return true }
    
    // 3. Формируем новую строку с учётом введённого/удалённого символа
    let updatedText = currentText.replacingCharacters(in: textRange, with: string)
    
    if updatedText.isEmpty {
      textFieldChange?(0)
      return true
    } else if let rgbValue = Int(updatedText), rgbValue >= 0 && rgbValue <= 255 {
      textFieldChange?(rgbValue)
      return true
    } else {
      return false
    }
  }
}

// MARK: - Private funcs

private extension RGBImputView {
  func setLayout() {
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: 32),
      self.widthAnchor.constraint(equalToConstant: 52)
    ])
  }
  
  func initial() {
    borderStyle = .roundedRect
    backgroundColor = .white
    delegate = self
  }
}

