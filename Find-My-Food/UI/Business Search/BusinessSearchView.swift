import UIKit

protocol BusinessSearchViewDelegate: class {
    func deSelected(_ price: String)
    func search(for business: String, radius: Int, prices: [String], openNow: Bool)
    func selected(_ price: String)
}

final class BusinessSearchView: UIView {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var firstPriceButton: PriceButton!
    @IBOutlet private weak var secondPriceButton: PriceButton!
    @IBOutlet private weak var thirdPriceButton: PriceButton!
    @IBOutlet private weak var fourthPriceButton: PriceButton!
    @IBOutlet private weak var radiusPickerView: UIPickerView!
    @IBOutlet private weak var openNowSwitch: UISwitch!
    @IBOutlet private weak var locationTextField: UITextField! // TODO: - Hide and display this based on user's location being shared or not.
	@IBOutlet private weak var searchButton: UIButton!

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let radiusPickerData = Array(1...25)

    private var selectedPrices = [String]()

	weak var delegate: BusinessSearchViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.center = self.center
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)

        firstPriceButton.delegate = self
        secondPriceButton.delegate = self
        thirdPriceButton.delegate = self
        fourthPriceButton.delegate = self

        radiusPickerView.delegate = self
        radiusPickerView.dataSource = self
        // TODO: - Use the default radius in UserDefaults here.
        radiusPickerView.selectRow(Radius.rangeMax, inComponent: 0, animated: false)

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

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }

    @IBAction private func priceButtonTapped(_ sender: PriceButton) {
        sender.isActive.toggle()
    }

	@IBAction private func searchButtonTapped(_ sender: Any) {
		guard let business = searchTextField.text, !business.isEmpty else { return }

        let radius = radiusPickerData[radiusPickerView.selectedRow(inComponent: 0)]
        let openNow = openNowSwitch.isOn

        delegate?.search(for: business, radius: radius, prices: selectedPrices, openNow: openNow)
	}

    @objc func dismissKeyboard() {
        endEditing(true)
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

        let contentInset = UIEdgeInsets.zero
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
        1
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
        delegate?.selected(price)
    }

    func deSelected(_ price: String) {
        delegate?.deSelected(price)
    }
}
