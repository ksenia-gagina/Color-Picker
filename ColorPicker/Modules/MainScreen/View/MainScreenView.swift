//
//  MainScreenView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 10.12.2024.
//

import UIKit

final class MainScreenView: UIView {
  
  // MARK: - Private propertes
  
  private let rgbDispleyView = RGBDispleyView()
  
  private let verticalStackLabel = UIStackView()
  private let redLabel = UILabel()
  private let greenLabel = UILabel()
  private let blueLabel = UILabel()
  
  private let verticalStackSlider = UIStackView()
  private let redSlider = RGBSliderView()
  private let greenSlider = RGBSliderView()
  private let blueSlider = RGBSliderView()
  
  private let verticalStackInputView = UIStackView()
  
  private let mainStackView = UIStackView()
  
  private let rgbSliderView = RGBSliderView()
  private let rdbInputView = RGBImputView()
  
  private let redInputView = RGBImputView()
  private let greenInputView = RGBImputView()
  private let blueInputView = RGBImputView()
  
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
    [rgbDispleyView, mainStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    [redLabel, greenLabel, blueLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackLabel.addArrangedSubview($0)
    }
    
    [redSlider, greenSlider, blueSlider].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackSlider.addArrangedSubview($0)
    }
    
    [redInputView, greenInputView, blueInputView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackInputView.addArrangedSubview($0)
    }
    
    [verticalStackLabel, verticalStackSlider, verticalStackInputView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      mainStackView.addArrangedSubview($0)
    }
    
    NSLayoutConstraint.activate(
      [
        rgbDispleyView.heightAnchor.constraint(
          equalToConstant: Constants.screenWithFinalColorViewHeight
        ),
        rgbDispleyView.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: Constants.screenWithFinalColorViewLeadingTrailingConstant
        ),
        rgbDispleyView.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -Constants.screenWithFinalColorViewLeadingTrailingConstant
        ),
        rgbDispleyView.topAnchor.constraint(
          equalTo: topAnchor,
          constant: Constants.screenWithFinalColorViewTop
        ),
        
        mainStackView.topAnchor.constraint(
          equalTo: rgbDispleyView.bottomAnchor,
          constant: Constants.commonStackWithFunctionalityTop
        ),
        mainStackView.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: Constants.commonStackWithFunctionalityLeadingTrailingConstant
        ),
        mainStackView.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -Constants.commonStackWithFunctionalityLeadingTrailingConstant
        ),
        mainStackView.bottomAnchor.constraint(
          equalTo: bottomAnchor,
          constant: -Constants.commonStackWithFunctionalityBottom
        ),
        
        verticalStackLabel.widthAnchor.constraint(
          equalToConstant: Constants.rgbDispleyViewWidth
        ),
        verticalStackLabel.heightAnchor.constraint(
          equalToConstant: Constants.rgbDispleyViewHeight
        )
      ]
    )
  }
  
  func settingStyle() {
    rgbDispleyView.layer.borderWidth = Constants.screenWithFinalColorViewBorderWidth
    rgbDispleyView.layer.borderColor = UIColor.black.cgColor
    
    verticalStackLabel.axis = .vertical
    verticalStackLabel.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackLabel.alignment = .leading
    
    let defaultValue = 127
    redSlider.value = Float(defaultValue)
    greenSlider.value = Float(defaultValue)
    blueSlider.value = Float(defaultValue)
    
    redLabel.text = "\(defaultValue)"
    redLabel.textAlignment = .center
    greenLabel.text = "\(defaultValue)"
    greenLabel.textAlignment = .center
    blueLabel.text = "\(defaultValue)"
    blueLabel.textAlignment = .center
    
    verticalStackSlider.axis = .vertical
    verticalStackSlider.spacing = Constants.verticalStackSliderSpacing
    verticalStackSlider.alignment = .fill
    verticalStackSlider.distribution = .fill
    
    redSlider.tintColor = .red
    greenSlider.tintColor = .green
    blueSlider.tintColor = .blue
    
    verticalStackInputView.axis = .vertical
    verticalStackInputView.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackInputView.alignment = .trailing
    
    mainStackView.axis = .horizontal
    mainStackView.spacing = Constants.commonStackWithFunctionalitySpacing
    mainStackView.alignment = .center
    mainStackView.distribution = .fill
    
    redInputView.setRGB(value: defaultValue)
    greenInputView.setRGB(value: defaultValue)
    blueInputView.setRGB(value: defaultValue)
    
    
    setupSlidersAndInputs(redSlider, redLabel, redInputView, .red)
    setupSlidersAndInputs(greenSlider, greenLabel, greenInputView, .green)
    setupSlidersAndInputs(blueSlider, blueLabel, blueInputView, .blue)
    
    updateBackgroundAndScreen()

  }
  
  func setupSlidersAndInputs(_ slider: RGBSliderView, _ label: UILabel, _ inputView: RGBImputView, _ color: UIColor) {
    configureSlider(slider, color: color)
    bindSlider(slider, label: label, inputView: inputView)
    bindInputView(inputView, slider: slider, label: label)
  }
  
  private func configureSlider(_ slider: RGBSliderView, color: UIColor) {
    slider.tintColor = color
  }
  
  private func bindSlider(_ slider: RGBSliderView, label: UILabel, inputView: RGBImputView) {
    slider.sliderValueChanged = { [weak self] _ in
      guard let self else { return }
      self.updateUIForSliderChange(slider, label: label, inputView: inputView)
    }
  }
  
  private func bindInputView(_ inputView: RGBImputView, slider: RGBSliderView, label: UILabel) {
    inputView.textFieldChange = { [weak self] value in
      guard let self else { return }
      self.updateUIForInputChange(inputView, slider: slider, label: label, value: value)
    }
  }
  
  private func updateUIForSliderChange(_ slider: RGBSliderView, label: UILabel, inputView: RGBImputView) {
    let value = Int(slider.value)
    label.text = "\(value)"
    inputView.setRGB(value: value)
    updateBackgroundAndScreen()
  }
  
  private func updateUIForInputChange(_ inputView: RGBImputView, slider: RGBSliderView, label: UILabel, value: Int) {
    slider.value = Float(value)
    label.text = "\(value)"
    updateBackgroundAndScreen()
  }
  
  private func updateBackgroundAndScreen() {
    setBackgroundColor()
    rgbScreenView()
  }
  
  func setBackgroundColor() {
    let redValue = Int(redSlider.value)
    let greenValue = Int(greenSlider.value)
    let blueValue = Int(blueSlider.value)
    
    if redValue == Constants.minimumValue && greenValue == Constants.minimumValue && blueValue == Constants.minimumValue {
      self.backgroundColor = .gray
      backgroundColor = .gray.withAlphaComponent(Constants.alphaComponentBackgroundColor)
      rgbDispleyView.tintColor = .black
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
    rgbDispleyView.setColor (
      redValue: Int(redSlider.value),
      greenValue: Int(greenSlider.value),
      blueValue: Int(blueSlider.value)
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
  static let rgbDispleyViewWidth: CGFloat = 36
  static let rgbDispleyViewHeight: CGFloat = 106
}
