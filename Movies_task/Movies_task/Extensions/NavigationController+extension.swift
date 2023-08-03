//
//  NavigationController+extension.swift
//  Movies_task
//
//  Created by Eslam Ali  on 03/08/2023.
//

import UIKit

extension UINavigationController {
    
    func hideBackground(){
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    func showBackground(){
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.isTranslucent = false
    }
    func setBackTitle(title: String)  {
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
extension UIViewController {
    private func setTitle(_ title: String?) {
        guard let title = title else { return }
        navigationItem.title = title
    }
    
    private func setBackButtonTitle(_ backButtonTitle: String?) {
        guard let navigationBar = navigationController?.navigationBar, let backButtonTitle = backButtonTitle else { return }
        let backItem = UIBarButtonItem()
        backItem.title = backButtonTitle
        navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    private func setBarTintColor(_ barTintColor: UIColor?, for traitCollection: UITraitCollection?) {
        guard let navigationBar = navigationController?.navigationBar, let barTintColor = barTintColor else { return }
        navigationBar.barTintColor = barTintColor
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.configureWithOpaqueBackground()
            if let traitCollection = traitCollection {
                if traitCollection.userInterfaceStyle == .light {
                    navigationBar.standardAppearance.backgroundColor = barTintColor
                } else {
                    //navigationBar.standardAppearance.backgroundColor = R.color.color_main()
                }
            } else {
                navigationBar.standardAppearance.backgroundColor = barTintColor
            }
        }
    }
    private func setTitleFont(_ font: UIFont?) {
        guard let navigationBar = navigationController?.navigationBar, let font = font else { return }
        navigationBar.titleTextAttributes = [.font: font]
        if #available(iOS 11.0, *) {
//            navigationItem.largeTitleDisplayMode = .automatic
            navigationBar.largeTitleTextAttributes = [.font: font]
            if #available(iOS 13.0, *) {
                navigationBar.standardAppearance.titleTextAttributes = [.font: font]
                navigationBar.standardAppearance.largeTitleTextAttributes = [.font: font]
            }
        }
    }
    private func setTitleColor(_ titleColor: UIColor? , font: UIFont? = nil) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        var attributes = [NSAttributedString.Key : Any]()
        
        if let font = font {
            attributes[.font] =  font
        }
        if let titleColor = titleColor {
            attributes[.foregroundColor] = titleColor
        }
        navigationBar.titleTextAttributes = attributes
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = attributes
            if #available(iOS 13.0, *) {
                navigationBar.standardAppearance.titleTextAttributes = attributes
                navigationBar.standardAppearance.largeTitleTextAttributes = attributes
            }
        }
    }
    
    private func setTintColor(_ tintColor: UIColor?) {
        guard let navigationBar = navigationController?.navigationBar, let tintColor = tintColor else { return }
        navigationBar.tintColor = tintColor
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.buttonAppearance.configureWithDefault(for: .plain)
            navigationBar.standardAppearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]
        }
    }
    
    private func setShadowImage(_ shadowImage: UIImage?) {
        guard let navigationBar = navigationController?.navigationBar, let shadowImage = shadowImage else { return }
        navigationBar.shadowImage = shadowImage
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.shadowImage = shadowImage
        }
    }
    
    private func setShadowColor(_ shadowColor: UIColor?) {
        guard let navigationController = navigationController, let shadowColor = shadowColor else { return }
        navigationController.setShadowColor(shadowColor)
        if #available(iOS 13.0, *) {
            navigationController.navigationBar.standardAppearance.shadowColor = shadowColor
        }
    }
    
    private func setLargeTitleDisplayMode(_ largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode?) {
        guard let largeTitleDisplayMode = largeTitleDisplayMode, #available(iOS 11.0, *)  else { return }
        navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
    }
    
    private func setIsTranslucent(_ isTranslucent: Bool?) {
        guard let navigationBar = navigationController?.navigationBar, let isTranslucent = isTranslucent else { return }
        navigationBar.isTranslucent = isTranslucent
    }
    
    private func setIsNavigationBarHidden(_ isNavigationBarHidden: Bool?) {
        guard let navigationController = navigationController, let isNavigationBarHidden = isNavigationBarHidden else { return }
        navigationController.isNavigationBarHidden = isNavigationBarHidden
    }
    
    private func setPrefersLargeTitles(_ prefersLargeTitles: Bool?) {
        guard let navigationBar = navigationController?.navigationBar, let prefersLargeTitles = prefersLargeTitles, #available(iOS 11.0, *) else { return }
        navigationBar.prefersLargeTitles = prefersLargeTitles
    }
    
    private func setHidesSearchBarWhenScrolling(_ hidesSearchBarWhenScrolling: Bool?) {
        guard let hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling, #available(iOS 11.0, *) else { return }
        navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
    }
    
    private func setIsUserInteractionEnabled(_ isUserInteractionEnabled: Bool?) {
        guard let navigationBar = navigationController?.navigationBar, let isUserInteractionEnabled = isUserInteractionEnabled else { return }
        navigationBar.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    private func setSearchController(_ searchController: UISearchController?) {
        guard let searchController = searchController, #available(iOS 11.0, *) else { return }
        navigationItem.searchController = searchController
    }
    
    // TODO: Refactor this part of styling navigation bar
    public func setupNavigationbar(
        title: String? = nil,
        titleFont : UIFont? = nil,
        backButtonTitle: String? = nil,
        barTintColor: UIColor? = nil,
        tintColor: UIColor? = nil,
        titleColor: UIColor? = nil,
        shadowColor: UIColor? = nil,
        shadowImage: UIImage? = nil,
        largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode? = nil,
        isTranslucent: Bool? = nil,
        isNavigationBarHidden: Bool? = nil,
        prefersLargeTitles: Bool? = nil,
        hidesSearchBarWhenScrolling: Bool? = nil,
        isUserInteractionEnabled: Bool? = nil,
        searchController: UISearchController? = nil,
        for traitCollection: UITraitCollection? = nil) {
            setTitle(title)
            //setTitleFont(titleFont)
            setBackButtonTitle(backButtonTitle)
            setBarTintColor(barTintColor, for: traitCollection)
            setTintColor(tintColor)
            setTitleColor(titleColor, font: titleFont)
            setShadowColor(shadowColor)
            setShadowImage(shadowImage)
            setLargeTitleDisplayMode(largeTitleDisplayMode)
            setIsTranslucent(isTranslucent)
            setIsNavigationBarHidden(isNavigationBarHidden)
            setPrefersLargeTitles(prefersLargeTitles)
            setHidesSearchBarWhenScrolling(hidesSearchBarWhenScrolling)
            setIsUserInteractionEnabled(isUserInteractionEnabled)
            setSearchController(searchController)
            if #available(iOS 13.0, *) {
                navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
                navigationController?.navigationBar.compactAppearance = navigationController?.navigationBar.standardAppearance
            }
            navigationController?.navigationBar.setNeedsLayout()
            navigationController?.navigationBar.layoutIfNeeded()
            navigationController?.navigationBar.setNeedsDisplay()
        }
}
typealias DatePickerHandler = (_ success: Bool, _ date:Date) -> Void
extension UIViewController{
    func showDatePicker(completionHandler: @escaping DatePickerHandler){
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: vc.view.bounds.width, height: 300))
        pickerView.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
         vc.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor,constant: 8),
            pickerView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor,constant: 8),
            pickerView.topAnchor.constraint(equalTo: vc.view.topAnchor,constant: 8),
            pickerView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor,constant: 8),
        ])

           let editRadiusAlert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
           editRadiusAlert.setValue(vc, forKey: "contentViewController")
           editRadiusAlert.addAction(UIAlertAction(title: "إختر", style: .default, handler: {action in
            completionHandler(true,pickerView.date)
           }))
           editRadiusAlert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: {action in
                completionHandler(false,Date())
           }))
           self.present(editRadiusAlert, animated: true)
    }
}
