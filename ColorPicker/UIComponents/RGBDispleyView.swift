//
//  RGBDispleyView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 03.01.2025.
//

import UIKit

public final class RGBDispleyView: UIView {
  
  // MARK: - Init
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    initial()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public func
  
  public func setColor(redValue: Int, greenValue: Int, blueValue: Int) {
    guard redValue >= Constants.minimumValue && redValue <= Constants.maximumValue else { return }
    guard greenValue >= Constants.minimumValue && greenValue <= Constants.maximumValue else { return }
    guard blueValue >= Constants.minimumValue && blueValue <= Constants.maximumValue else { return }
    
    backgroundColor = UIColor(
      red: CGFloat(redValue) / CGFloat(Constants.maximumValue),
      green: CGFloat(greenValue) / CGFloat(Constants.maximumValue),
      blue: CGFloat(blueValue) / CGFloat(Constants.maximumValue),
      alpha: Constants.alphaComponentBackgroundColor
    )
  }
}

// MARK: - Private func

private extension RGBDispleyView {
  func initial() {
    backgroundColor = .white
    layer.cornerRadius = Constants.rgbDispleyCornerRadius
  }
}

//MARK: - Constants

private enum Constants {
  static let minimumValue: Int = 0
  static let maximumValue: Int = 255
  static let alphaComponentBackgroundColor: CGFloat = 0.4
  static let rgbDispleyCornerRadius: CGFloat = 45
  
}
