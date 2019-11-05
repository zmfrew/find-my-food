import UIKit

protocol BusinessSearchViewDelegate: class {
    func search(for business: String, radius: Int, price: String, openNow: Bool)
}

final class BusinessSearchView: UIView {
	@IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var radiusPicker: UIPickerView!
    @IBOutlet private weak var pricePicker: UIPickerView! // TODO: - Change this so that multiple prices can be selected
    @IBOutlet private weak var openNowSwitch: UISwitch!
    @IBOutlet private weak var locationTextField: UITextField! // TODO: - Hide and display this based on user's location being shared or not.
	@IBOutlet private weak var searchButton: UIButton!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let radiusPickerData = Array(1...25)
    private let pricePickerData = ["$", "$$", "$$$", "$$$$"]
	
	weak var delegate: BusinessSearchViewDelegate?
	
    override func awakeFromNib() {
        activityIndicator.center = self.center
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        
        radiusPicker.delegate = self
        radiusPicker.dataSource = self
        pricePicker.delegate = self
        pricePicker.dataSource = self
    }
    
	@IBAction private func searchButtonTapped(_ sender: Any) {
		guard let business = searchTextField.text, !business.isEmpty else { return }
		
        let radius = radiusPickerData[radiusPicker.selectedRow(inComponent: 0)]
        let price = pricePickerData[pricePicker.selectedRow(inComponent: 0)]
        let openNow = openNowSwitch.isOn
        
        delegate?.search(for: business, radius: radius, price: price, openNow: openNow)
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
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.resignFirstResponder()
	}
}

extension BusinessSearchView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return radiusPickerData.count
        case 1:
            return pricePickerData.count
        default:
            return 0
        }
    }
}

extension BusinessSearchView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(row + 1) \(row == 0 ? "mile" : "miles")"
        case 1:
            return "\(pricePickerData[row])"
        default:
            return nil
        }
    }
}
