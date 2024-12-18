//
//  MainScreenView.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 18.12.2024.
//

import UIKit

final class MainScreenView: UIView, UITextFieldDelegate {
  
  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    settingLayout()
    settingStyle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal propertes
  
  var textField: (() -> Void)?
  
  // MARK: - Private properties
  
  private let screenWithFinalColorView = UIView()
  
  private let verticalStackLabel = UIStackView()
  private let labelRed = UILabel()
  private let labelGreen = UILabel()
  private let labelBlue = UILabel()
  
  private let verticalStackSlider = UIStackView()
  private let sliderRed = UISlider()
  private let sliderGreen = UISlider()
  private let sliderBlue = UISlider()
  
  private let verticalStackTextField = UIStackView()
  private let textFieldRed = UITextField()
  private let textFieldGreen = UITextField()
  private let textFieldBlue = UITextField()
  
  private let CommonStackWithFunctionality = UIStackView()
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
    
    [textFieldRed, textFieldGreen, textFieldBlue].forEach {
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
      ]
    )
  }
  
  func settingStyle() {
    backgroundColor = .white
    
    screenWithFinalColorView.layer.cornerRadius = Constants.screenWithFinalColorViewCornerRadius
    screenWithFinalColorView.layer.borderWidth = Constants.screenWithFinalColorViewBorderWidth
    screenWithFinalColorView.layer.borderColor = UIColor.black.cgColor
    
    verticalStackLabel.axis = .vertical
    verticalStackLabel.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackLabel.alignment = .leading
    
    
    labelRed.text = "\(sliderRed.value)"
    labelRed.textAlignment = .left
    labelGreen.text = "\(sliderGreen.value)"
    labelGreen.textAlignment = .left
    labelBlue.text = "\(sliderBlue.value)"
    labelBlue.textAlignment = .left
    
    
    verticalStackSlider.axis = .vertical
    verticalStackSlider.spacing = Constants.verticalStackSliderSpacing
    verticalStackSlider.alignment = .fill
    verticalStackSlider.distribution = .fill
    
    verticalStackTextField.axis = .vertical
    verticalStackTextField.spacing = Constants.verticalStackLabelTextFieldSpacing
    verticalStackTextField.alignment = .trailing
    
    [textFieldRed, textFieldGreen, textFieldBlue].forEach {
      $0.borderStyle = .roundedRect
      $0.delegate = self
      $0.addTarget(self, action: #selector(textFieldActivate), for: .allEditingEvents)
    }
    
    CommonStackWithFunctionality.axis = .horizontal
    CommonStackWithFunctionality.spacing = Constants.commonStackWithFunctionalitySpacing
    CommonStackWithFunctionality.alignment = .center
    CommonStackWithFunctionality.distribution = .fill
    
    [sliderRed,sliderGreen, sliderBlue].forEach {
      $0.minimumValue = Float(Constants.minimumValue)
      $0.maximumValue = Float(Constants.maximumValue)
      $0.value = Float(Constants.minimumValue)
      $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
  }
  
  @objc
  func sliderValueChanged(_ sender: UISlider) {
    let redValue = CGFloat(sliderRed.value) / Constants.maximumValue
    let greenValue = CGFloat(sliderGreen.value) / Constants.maximumValue
    let blueValue = CGFloat(sliderBlue.value) / Constants.maximumValue
    let backgroundColor = UIColor(
      red: redValue,
      green: greenValue,
      blue: blueValue, alpha: Constants.alphaBackgroundColor
    )
    self.backgroundColor = backgroundColor.withAlphaComponent(Constants.alphaComponentBackgroundColor)
    self.screenWithFinalColorView.backgroundColor = backgroundColor
    self.labelRed.text = String(Int(redValue * Constants.maximumValue))
    self.labelGreen.text = String (Int(greenValue * Constants.maximumValue))
    self.labelBlue.text = String (Int(blueValue * Constants.maximumValue))
    
    self.textFieldRed.text = String(Int(redValue * Constants.maximumValue))
    self.textFieldGreen.text = String (Int(greenValue * Constants.maximumValue))
    self.textFieldBlue.text = String (Int(blueValue * Constants.maximumValue))
  }
  
  @objc
  func textFieldActivate (_ sender: UITextField) {
    textField?()
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
