//
//  MainScreenView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 10.12.2024.
//

import UIKit

final class MainScreenView: UIView {
  
  // MARK: - Private propertes
  
  private let screenWithFinalColorView = RGBDispleyView()
  
  private let verticalStackLabel = UIStackView()
  private let labelRed = UILabel()
  private let labelGreen = UILabel()
  private let labelBlue = UILabel()
  
  private let verticalStackSlider = UIStackView()
  private let sliderRed = RGBSliderView()
  private let sliderGreen = RGBSliderView()
  private let sliderBlue = RGBSliderView()
  
  private let verticalStackTextField = UIStackView()
  
  private let CommonStackWithFunctionality = UIStackView()
  
  private let rgbInputRedView = RGBImputView()
  private let rgbInputGreenView = RGBImputView()
  private let rgbInputBlueView = RGBImputView()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    settingLayout()
    settingStyle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private functions

private extension MainScreenView {
  func settingLayout() {
    [screenWithFinalColorView, CommonStackWithFunctionality].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    [labelRed, labelGreen, labelBlue].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackLabel.addArrangedSubview($0)
    }
    
    [sliderRed, sliderGreen, sliderBlue].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackSlider.addArrangedSubview($0)
    }
    
    [rgbInputRedView, rgbInputGreenView, rgbInputBlueView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackTextField.addArrangedSubview($0)
    }
    
    [verticalStackLabel, verticalStackSlider, verticalStackTextField, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      CommonStackWithFunctionality.addArrangedSubview($0)
    }
    
    NSLayoutConstraint.activate(
      [
        screenWithFinalColorView.heightAnchor.constraint(
          equalToConstant: Constants.screenWithFinalColorViewHeight
        ),
        screenWithFinalColorView.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: Constants.screenWithFinalColorViewLeadingTrailingConstant
        ),
        screenWithFinalColorView.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -Constants.screenWithFinalColorViewLeadingTrailingConstant
        ),
        screenWithFinalColorView.topAnchor.constraint(
          equalTo: topAnchor,
          constant: Constants.screenWithFinalColorViewTop
        ),
        
        CommonStackWithFunctionality.topAnchor.constraint(
          equalTo: screenWithFinalColorView.bottomAnchor,
          constant: Constants.commonStackWithFunctionalityTop
        ),
        CommonStackWithFunctionality.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: Constants.commonStackWithFunctionalityLeadingTrailingConstant
        ),
        CommonStackWithFunctionality.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -Constants.commonStackWithFunctionalityLeadingTrailingConstant
        ),
        CommonStackWithFunctionality.bottomAnchor.constraint(
          equalTo: bottomAnchor,
          constant: -Constants.commonStackWithFunctionalityBottom
        ),
        
        verticalStackLabel.widthAnchor.constraint(
          equalToConstant: 36
        ),
        verticalStackLabel.heightAnchor.constraint(
          equalToConstant: 106
        )
      ]
    )
  }
  
  func settingStyle() {
    screenWithFinalColorView.layer.borderWidth = Constants.screenWithFinalColorViewBorderWidth
    screenWithFinalColorView.layer.borderColor = UIColor.black.cgColor
    
    verticalStackLabel.axis = .vertical
    verticalStackLabel.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackLabel.alignment = .leading
    
    labelRed.text = "\(sliderRed.value)"
    labelRed.textAlignment = .center
    labelGreen.text = "\(sliderGreen.value)"
    labelGreen.textAlignment = .center
    labelBlue.text = "\(sliderBlue.value)"
    labelBlue.textAlignment = .center
    
    verticalStackSlider.axis = .vertical
    verticalStackSlider.spacing = Constants.verticalStackSliderSpacing
    verticalStackSlider.alignment = .fill
    verticalStackSlider.distribution = .fill
    
    sliderRed.tintColor = .red
    sliderGreen.tintColor = .green
    sliderBlue.tintColor = .blue
    
    verticalStackTextField.axis = .vertical
    verticalStackTextField.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackTextField.alignment = .trailing
    
    CommonStackWithFunctionality.axis = .horizontal
    CommonStackWithFunctionality.spacing = Constants.commonStackWithFunctionalitySpacing
    CommonStackWithFunctionality.alignment = .center
    CommonStackWithFunctionality.distribution = .fill
    
    sliderRed.sliderValueChanged = { [weak self] sliderValue in
      guard let self else { return }
      labelRed.text = String(format: "%.0f", sliderRed.value)
      rgbInputRedView.setRGB(value: Int(sliderRed.value))
      rgbScreenView()
      setBackgroundColor()
    }
    
    sliderGreen.sliderValueChanged = { [weak self] sliderValue in
      guard let self else { return }
      labelGreen.text = String(format: "%.0f", sliderGreen.value)
      rgbInputGreenView.setRGB(value: Int(sliderGreen.value))
      rgbScreenView()
      setBackgroundColor()
    }
    
    sliderBlue.sliderValueChanged = { [weak self] sliderValue in
      guard let self else { return }
      labelBlue.text = String(format: "%.0f", sliderBlue.value)
      rgbInputBlueView.setRGB(value: Int(sliderBlue.value))
      rgbScreenView()
      setBackgroundColor()
    }
    
    rgbInputRedView.textFieldChange = { [weak self] rgbValue in
      guard let self else { return }
      sliderRed.value = Float(rgbValue)
      labelRed.text = String(rgbValue)
      rgbScreenView()
      setBackgroundColor()
    }
    
    rgbInputGreenView.textFieldChange = { [weak self] rgbValue in
      guard let self else { return }
      sliderGreen.value = Float(rgbValue)
      labelGreen.text = String(rgbValue)
      rgbScreenView()
      setBackgroundColor()
    }
    
    rgbInputBlueView.textFieldChange = { [weak self] rgbValue in
      guard let self else { return }
      sliderBlue.value = Float(rgbValue)
      labelBlue.text = String(rgbValue)
      rgbScreenView()
      setBackgroundColor()
    }
    setBackgroundColor()
  }
  
  func setBackgroundColor() {
    let redValue = Int(sliderRed.value)
    let greenValue = Int(sliderGreen.value)
    let blueValue = Int(sliderBlue.value)
    
    if redValue == Constants.minimumValue && greenValue == Constants.minimumValue && blueValue == Constants.minimumValue {
      self.backgroundColor = .gray
      backgroundColor?.withAlphaComponent(0.5)
      screenWithFinalColorView.tintColor = .black
    } else {
      guard redValue >= Constants.minimumValue && redValue <= Constants.maximumValue else { return }
      guard greenValue >= Constants.minimumValue  && greenValue <= Constants.maximumValue  else { return }
      guard blueValue >= Constants.minimumValue  && blueValue <= Constants.maximumValue  else { return }
      
      backgroundColor = UIColor(
        red: CGFloat(redValue) / CGFloat(Constants.maximumValue),
        green: CGFloat(greenValue) / CGFloat(Constants.maximumValue),
        blue: CGFloat(blueValue) / CGFloat(Constants.maximumValue),
        alpha: Constants.alphaComponentBackgroundColor
      )
    }
  }
  
  func rgbScreenView() {
    screenWithFinalColorView.setColor(
      redValue: Int(sliderRed.value),
      greenValue: Int(sliderGreen.value),
      blueValue: Int(sliderBlue.value)
    )
  }
}

//MARK: - Constants

private enum Constants {
  static let screenWithFinalColorViewHeight: CGFloat = 120
  static let screenWithFinalColorViewLeadingTrailingConstant: CGFloat = 30
  static let screenWithFinalColorViewTop: CGFloat = 180
  static let commonStackWithFunctionalityTop: CGFloat = 20
  static let commonStackWithFunctionalityLeadingTrailingConstant: CGFloat = 25
  static let commonStackWithFunctionalityBottom: CGFloat = 100
  static let screenWithFinalColorViewCornerRadius: CGFloat = 45
  static let screenWithFinalColorViewBorderWidth: CGFloat = 2
  static let verticalStackSliderSpacing: CGFloat = 20
  static let verticalStackLabelTextFieldSpacing: CGFloat = 25
  static let commonStackWithFunctionalitySpacing: CGFloat = 28
  static let minimumValue: Int = 0
  static let maximumValue: Int = 255
  static let alphaComponentBackgroundColor: CGFloat = 0.4
}
