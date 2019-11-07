import UIKit

protocol BusinessSearchViewDelegate: class {
    func search(for business: String, radius: Int, prices: [String], openNow: Bool)
}

final class BusinessSearchView: UIView {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet weak var firstPriceButton: PriceButton!
    @IBOutlet weak var secondPriceButton: PriceButton!
    @IBOutlet weak var thirdPriceButton: PriceButton!
    @IBOutlet weak var fourthPriceButton: PriceButton!
    @IBOutlet private weak var radiusPicker: UIPickerView!
    @IBOutlet private weak var openNowSwitch: UISwitch!
    @IBOutlet private weak var locationTextField: UITextField! // TODO: - Hide and display this based on user's location being shared or not.
	@IBOutlet private weak var searchButton: UIButton!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let radiusPickerData = Array(1...25)
    
    private var selectedPrices = [String]()
	
	weak var delegate: BusinessSearchViewDelegate?
	
    override func awakeFromNib() {
        activityIndicator.center = self.center
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        
        firstPriceButton.delegate = self
        secondPriceButton.delegate = self
        thirdPriceButton.delegate = self
        fourthPriceButton.delegate = self
        
        radiusPicker.delegate = self
        radiusPicker.dataSource = self
        radiusPicker.selectRow(24, inComponent: 0, animated: false)
        
        searchTextField.delegate = self
        locationTextField.delegate = self
        
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @IBAction func priceButtonTapped(_ sender: PriceButton) {
        sender.isActive.toggle()
    }
    
	@IBAction private func searchButtonTapped(_ sender: Any) {
		guard let business = searchTextField.text, !business.isEmpty else { return }
		
        let radius = radiusPickerData[radiusPicker.selectedRow(inComponent: 0)]
        let openNow = openNowSwitch.isOn
        
        delegate?.search(for: business, radius: radius, prices: selectedPrices, openNow: openNow)
	}
    
    @objc func keyboardWillShow(notification: NSNotification) {

        let userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue //swiftlint:disable:this force_cast
        keyboardFrame = self.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

extension BusinessSearchView {
    func downloadDidBegin() {
        activityIndicator.startAnimating()
    }

    func downloadDidEnd() {
        activityIndicator.stopAnimating()
    }
}

extension BusinessSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.resignFirstResponder()
	}
}

extension BusinessSearchView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        radiusPickerData.count
    }
}

extension BusinessSearchView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(row + 1) \(row == 0 ? "mile" : "miles")"
    }
}

extension BusinessSearchView: PriceButtonDelegate {
    func selected(_ price: String) {
        guard !selectedPrices.contains(price) else { return }
        
        selectedPrices.append(price)
    }
    
    func deSelected(_ price: String) {
        guard selectedPrices.contains(price) else { return }
        
        if let index = selectedPrices.firstIndex(of: price) {
            selectedPrices.remove(at: index)            
        }
    }
}
