//
//  UIViewControllerExtensions.swift
//  ZiraatKatilim
//
//  Created by Enqura on 01/10/16.
//  Copyright © 2016 Enqura Information Technologies. All rights reserved.
//
import UIKit

extension UIViewController {

    @IBInspectable var titleKey: String {
        set (key) {
            self.setHeader(key)
        }
        get {
            return self.navigationItem.title!
        }
    }
    
    var viewDidSearchedMenuId: Int {
        set (menuItemId) {
            self.viewDidSearched(menuItemId)
        }
        get {
            return -1
        }
    }
    
    /*
    
    public func slideMenuController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }
*/
    /*
     public func addLeftBarButtonWithImage(_ buttonImage: UIImage) {
     let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleLeft))
     self.navigationItem.leftBarButtonItem = leftButton
     }

     public func addRightBarButtonWithImage(_ buttonImage: UIImage) {
     let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleRight))
     self.navigationItem.rightBarButtonItem = rightButton
     }

    public func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }

    public func toggleRight() {
        slideMenuController()?.toggleRight()
    }

    public func openLeft() {
        slideMenuController()?.openLeft()
    }

    public func openRight() {
        slideMenuController()?.openRight()    }

    public func closeLeft() {
        slideMenuController()?.closeLeft()
    }

    public func closeRight() {
        slideMenuController()?.closeRight()
    }
*/
    // Please specify if you want menu gesuture give priority to than targetScrollView
    /*
    public func addPriorityToMenuGesuture(_ targetScrollView: UIScrollView) {
        guard let slideController = slideMenuController(), let recognizers = slideController.view.gestureRecognizers else {
            return
        }
        for recognizer in recognizers where recognizer is UIPanGestureRecognizer {
            targetScrollView.panGestureRecognizer.require(toFail: recognizer)
        }
    }
    */

    /**
     Override edilerek kullanılır.
     Bazı yerlerde detay ekran açılmadan önceki ekranda (menu list) bazı servis çağırları bulunur. Bu sebeple hedef ekrandan önceki ekranda
     override edilerek hedef ekrana geçiş yapılabileceği gibi direk hedef ekranda da override edilerek kullanılabilir.
     Ayrıca viewDidLoad'dan önce çalışması bir avantaj...
    **/
    func viewDidSearched(_ menuItemId: Int) {
        print("Override this on target or before target controller")
        return
    }
    
    func showAlert(_ pMessage: String, goBack: Bool) {
        let errorAlert = UIAlertController(
            title: "MessageBoxTitle".toLocalize(),
            message: pMessage,
            preferredStyle: UIAlertController.Style.alert)
        errorAlert.addAction(UIAlertAction(
            title: "Ok".toLocalize(),
            style: .default,
            handler: { _ in
                if goBack {
                   _ = self.navigationController?.popViewController(animated: true)
                }
        }))
        errorAlert.view.tintColor = UIColor.siemensLight()
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    /*
    func checkAuthorization(_ authorizeType: authorizationType, completion: @escaping (AuthorizationResult)->()) {
        let queue = DispatchQueue(label: "com.app.tcmb")
        queue.sync {
            _ = showProgress()
            let _ = AuthorizeService(transactionKey: authorizeType, didFinishLoading: { (hasAuthorizedResult) in
                self.dismissProgress()
                if hasAuthorizedResult == .notAuthorized {
                    self.showAlert("UnauthorizedTransaction".toLocalizeMsg(), goBack: false)
                }
                completion(hasAuthorizedResult)
            }) { (errorMessage) in
                self.dismissProgress()
                log.debug(errorMessage)
                log.error(errorMessage)
                self.showGeneralError()
                print(">>> extension içinde hata aldı : \(errorMessage)")
                completion(.error)
            }
        }
    }
    */

    func showSuccessAlert() {
        showAlert("SuccessfullyCompleted".toLocalizeMsg(), goBack: false)
    }
    /*
    func showErrorAlert(_ exceptionInfo: ExceptionInfoResponse?, goBack: Bool) {
        var vMessage="GeneralErrorMessage".toLocalize()
        guard let vException = exceptionInfo else {
            vMessage="GeneralErrorMessage".toLocalize()
            showAlert(vMessage, goBack: false)
            return
        }
        if vException.message != nil {
            vMessage=vException.message!
        }
        showAlert(vMessage, goBack: goBack)
    }
    */

    func showErrorAlert(_ exceptionMessage: String, goBack: Bool ) {
        //showErrorAlert(ExceptionInfoResponse(infoMessage: exceptionMessage), goBack: goBack)
    }

    func showGeneralError() {
        showErrorAlert("GeneralErrorMessage".toLocalizeMsg(), goBack: false)
    }

    func addDismissKeyboard() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(UIViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
    }

    @IBAction func dismissKeyboard() {
        self.view.endEditing(true)
    }

    public func setNextScreenBackItem(_ titleKey: String) {
        let backItem = UIBarButtonItem()
        backItem.title = titleKey.toLocalize()
        self.navigationItem.backBarButtonItem = backItem
    }
    public func formatSearchBar(_ searchController: UISearchController, titleKey: String) {
        searchController.searchBar.setValue("Cancel".toLocalize(), forKey: "_cancelButtonText")
        searchController.searchBar.barTintColor = UIColor.rowBackgroundGray()
        searchController.searchBar.tintColor = UIColor.siemensLight()
        let searchTextField: UITextField? = searchController.searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            //convert swift4
            //let attributeDict = [NSForegroundColorAttributeName: Style.defaultTextLightColor, NSFontAttributeName: Style.defaultTextNormalFont!] as [String : Any]
            
            //searchTextField!.attributedPlaceholder = NSAttributedString(string: titleKey.toLocalize(), attributes: attributeDict)
        }
    }

    public func addLogoTitle() {
        guard let navTitle = self.navigationItem.titleView else {
            let barBackground = UIImage(named: "smalllogo")
            //let barBackground = SessionManager.sharedInstance.language == .tr_TR ? UIImage(named: "smalllogo") : UIImage(named: "smalllogo_en")
            let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 140, height: 40.0))
            imageView.image = barBackground
            imageView.contentMode = .center
            self.navigationItem.titleView?.alpha = 0.0
            self.navigationItem.titleView = imageView
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.navigationItem.titleView?.alpha = 1.0
            }, completion: nil)
            return
        }
        navTitle.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            navTitle.alpha = 1.0
        }, completion: nil)
    }

    public func setHeader(_ pTitle: String) {
        self.navigationItem.title =  pTitle.toLocalize()
    }

    @IBAction func goBackAction() {
        self.goBack()
    }

    public func showProgress() -> UIView {
        return showProgress("")
    }

    public func showProgress(_ pMessage: String) -> UIView {
        return UIView()
/*
        let rect = CGRect(x: Constant.screenCenterX-48, y: Constant.screenCenterY-96, width: 96, height: 96)
        guard let vProgressView = SessionManager.sharedInstance.progress.show(frame: rect, message: pMessage, style: ProgressLoadingStyle()) else {
            return UIView()
        }
        vProgressView.backgroundColor = UIColor.black
        vProgressView.layer.cornerRadius = 10
        vProgressView.alpha = 0.7

        let blockView: UIView = UIView(frame: Constant.screenSize)
        blockView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.view.addSubview(blockView)

        blockView.addSubview(vProgressView)
        //self.view.addSubview(vProgressView)
        SessionManager.sharedInstance.progressView = blockView
        blockView.bringSubview(toFront: self.view)
        vProgressView.bringSubview(toFront: blockView)
        return blockView
 */
    }

    public func showProgressWithNavigationView(_ pMessage: String) -> UIView {
        return UIView()
/*
        let rect = CGRect(x: Constant.screenCenterX-48, y: Constant.screenCenterY-96, width: 96, height: 96)
        guard let vProgressView = SessionManager.sharedInstance.progress.show(frame: rect, message: pMessage, style: ProgressLoadingStyle()) else {
            return UIView()
        }
        vProgressView.backgroundColor = UIColor.black
        vProgressView.layer.cornerRadius = 10
        vProgressView.alpha = 0.7

        let blockView: UIView = UIView(frame: CGRect(x: 0, y: Constant.navigationBarHeight, width: Constant.screenWidth, height: Constant.screenHeight-Constant.navigationBarHeight))
        blockView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.view.addSubview(blockView)

        blockView.addSubview(vProgressView)
        //self.view.addSubview(vProgressView)
        SessionManager.sharedInstance.progressView = blockView
        blockView.bringSubview(toFront: self.view)
        vProgressView.bringSubview(toFront: blockView)
        return blockView
 */
    }

    public func dismissProgress() {
        //SessionManager.sharedInstance.progress.dismiss(progress: SessionManager.sharedInstance.progressView)
        //SessionManager.sharedInstance.progressView.removeFromSuperview()
    }

    /*
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        //self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }

    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
 */

    public func shakeView(_ pView: SpringView) {
        pView.animation = "shake"
        pView.curve = "easeIn"
        pView.duration = 0.5
        pView.animate()
    }
    public func shakeText(_ pTextField: SpringTextField) {
        pTextField.animation = "shake"
        pTextField.curve = "easeIn"
        pTextField.duration = 0.5
        pTextField.animate()
    }
    public func removeBackButton() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    public func addDoneButtonTo(_ textField: UITextField) {
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let keyboardToolbar = UIToolbar()
        let okButton = UIBarButtonItem(title: "Ok".toLocalize(), style: .plain, target: self, action: #selector(self.dismissKeyboard))
        okButton.tintColor = UIColor.siemensLight()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.items = [flexBarButton, okButton]
        textField.inputAccessoryView = keyboardToolbar
    }

    public func addRightButton(titleKey: String, method: Selector) {
        let customRightButton: UIButton = UIButton()
        customRightButton.setTitle(titleKey.toLocalize(), for: UIControl.State())
        customRightButton.frame = CGRect(x: 0, y: 0, width: 65, height: 45)
        customRightButton.titleLabel!.font = Style.defaultTextNormalFont
        customRightButton.setTitleColor(UIColor.white.withAlphaComponent(0.5),
                                        for: UIControl.State.disabled)
        customRightButton.setTitleColor(UIColor.headerGray().withAlphaComponent(0.8),
                                        for: UIControl.State.highlighted)

        customRightButton.addTarget(self, action: method, for: UIControl.Event.touchUpInside)
        customRightButton.titleLabel!.minimumScaleFactor = 0.5
        customRightButton.titleLabel!.adjustsFontSizeToFitWidth = true
        customRightButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        let rightBarItem: UIBarButtonItem = UIBarButtonItem()
        rightBarItem.customView = customRightButton
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    //@IBAction func rightBarButtonPressed(_ sender: Any){
    //    self.rightBarButtonPressed()
    //}
    //func rightBarButtonPressed() {
        //overrided by parent
    //}
    
    public func goToHomePage() {
        let alertController = UIAlertController(title: "MessageBoxTitle".toLocalize(),
                                                message: "AskForReturnHomePage".toLocalize(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".toLocalize(), style: UIAlertAction.Style.default) { _ in
            //self.returnMainScreen(self.slideMenuController())
        }
        let cancelAction = UIAlertAction(title: "Cancel".toLocalize(), style: UIAlertAction.Style.cancel) { _ in
            return
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor.siemensLight()
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func goBack() {
        _ = navigationController?.popViewController(animated: true)
    }
}
