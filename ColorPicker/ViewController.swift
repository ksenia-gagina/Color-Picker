//
//  ViewController.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 10.12.2024.
//

import UIKit

protocol ColorValueDelegate {
  func colorValueChanged() -> ()
}

final class ViewController: UIViewController {
  
  
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
  
  // MARK: - Internal functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingLayout()
    settingStyle()
  }
}

// MARK: - Private functions

private extension ViewController {
  func settingLayout() {
    [screenWithFinalColorView, CommonStackWithFunctionality].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
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
          equalToConstant: 100
        ),
        screenWithFinalColorView.leadingAnchor.constraint(
          equalTo: view.leadingAnchor,
          constant: 30
        ),
        screenWithFinalColorView.trailingAnchor.constraint(
          equalTo: view.trailingAnchor,
          constant: -30
        ),
        screenWithFinalColorView.topAnchor.constraint(
          equalTo: view.topAnchor,
          constant: 180
        ),
        
        CommonStackWithFunctionality.topAnchor.constraint(
          equalTo: screenWithFinalColorView.bottomAnchor,
          constant: 20
        ),
        CommonStackWithFunctionality.leadingAnchor.constraint(
          equalTo: view.leadingAnchor,
          constant: 25
        ),
        CommonStackWithFunctionality.trailingAnchor.constraint(
          equalTo: view.trailingAnchor,
          constant: -25
        ),
        CommonStackWithFunctionality.bottomAnchor.constraint(
          equalTo: view.bottomAnchor,
          constant: -100
        ),
      ]
    )
  }
  
  func settingStyle() {
    view.backgroundColor = .white
    
    screenWithFinalColorView.layer.cornerRadius = 45
    screenWithFinalColorView.layer.borderWidth = 2
    screenWithFinalColorView.layer.borderColor = UIColor.black.cgColor
    
    verticalStackLabel.axis = .vertical
    verticalStackLabel.spacing = 25
    verticalStackLabel.alignment = .leading
    
    
    labelRed.text = "\(sliderRed.value)"
    labelRed.textAlignment = .left
    labelGreen.text = "\(sliderGreen.value)"
    labelGreen.textAlignment = .left
    labelBlue.text = "\(sliderBlue.value)"
    labelBlue.textAlignment = .left
    
    
    verticalStackSlider.axis = .vertical
    verticalStackSlider.spacing = 20
    verticalStackSlider.alignment = .fill
    verticalStackSlider.distribution = .fill
    
    verticalStackTextField.axis = .vertical
    verticalStackTextField.spacing = 25
    verticalStackTextField.alignment = .trailing
    
    [textFieldRed, textFieldGreen, textFieldBlue].forEach {
      $0.borderStyle = .roundedRect
      $0.delegate = self
    }
    
    CommonStackWithFunctionality.axis = .horizontal
    CommonStackWithFunctionality.spacing = 20
    CommonStackWithFunctionality.alignment = .center
    CommonStackWithFunctionality.distribution = .fill
    
    [sliderRed,sliderGreen, sliderBlue].forEach {
      $0.minimumValue = 0
      $0.maximumValue = 255
      $0.value = 0
      $0.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
  }
  
  @objc func sliderValueChanged(_ sender: UISlider) {
    let redValue = CGFloat(sliderRed.value) / 255
    let greenValue = CGFloat(sliderGreen.value) / 255
    let blueValue = CGFloat(sliderBlue.value) / 255
    let backgroundColor = UIColor(
      red: redValue,
      green: greenValue,
      blue: blueValue, alpha: 1.0
    )
    self.view.backgroundColor = backgroundColor.withAlphaComponent(0.5)
    self.screenWithFinalColorView.backgroundColor = backgroundColor
    self.labelRed.text = String(Int(redValue * 255))
    self.labelGreen.text = String (Int(greenValue * 255))
    self.labelBlue.text = String (Int(blueValue * 255))
    
    self.textFieldRed.text = String(Int(redValue * 255))
    self.textFieldGreen.text = String (Int(greenValue * 255))
    self.textFieldBlue.text = String (Int(blueValue * 255))
  }
}
  extension ViewController: UITextFieldDelegate {
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      textField.text?.count ?? 0 < 3
          }
      }
  
