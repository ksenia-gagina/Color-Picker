//
//  RGBSliderView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 03.01.2025.
//

import UIKit

public final class RGBSliderView: UISlider {
  
  // MARK: - Public properties
  
  public var sliderValueChanged: ((Float) -> Void)?
  
  // MARK: - Init
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    initial()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public funcs
  
  func setValue(_ value: Float) {
    self.value = value
  }
}

// MARK: - Private funcs

private extension RGBSliderView {
  func initial() {
    minimumValue = Float(Int(Constants.minimumValue))
    maximumValue = Float(Int(Constants.maximumValue))
    value = Float(Constants.minimumValue)
    addTarget(self, action: #selector(sliderValueChangedAction), for: .valueChanged)
  }
  
  @objc
  private func sliderValueChangedAction() {
    sliderValueChanged?(value)
  }
}

//MARK: - Constants

private enum Constants {
  static let minimumValue: CGFloat = 0
  static let maximumValue: CGFloat = 255
}
