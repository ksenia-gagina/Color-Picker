//
//  MainScreenViewController.swift
//  ColorPicker
//
//  Created by Ксения Гагина on 18.12.2024.

import UIKit

final class MainScreenViewController: UIViewController {
  
  // MARK: - Private propertes
  
  private let moduleView = MainScreenView()
  
  // MARK: - Internal functions
  
  override func loadView() {
    super.loadView()
    
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
