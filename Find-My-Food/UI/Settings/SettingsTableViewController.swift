import UIKit

final class SettingsTableViewController: UITableViewController, Storyboarded {
    @IBOutlet private weak var defaultLocationTextField: UITextField!
    @IBOutlet private weak var radiusPickerView: UIPickerView!
    @IBOutlet private weak var saveButton: UIButton!

    weak var coordinator: SettingsCoordinatorProtocol?
    private var model: SettingsModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
        radiusPickerView.delegate = self
        radiusPickerView.dataSource = self
        radiusPickerView.selectRow(Radius.rangeMax, inComponent: 0, animated: false)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .background
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        let selectedRadius = radiusPickerView.selectedRow(inComponent: 0)
        let defaultLocation = defaultLocationTextField.text
        let radiusIndex = model.radius(at: selectedRadius)

        model.selectedDefaults(defaultLocation: defaultLocation, radiusIndex: radiusIndex)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SettingsTableViewController {
    func configure(with model: SettingsModelProtocol) {
        self.model = model
    }
}

extension SettingsTableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        model.radiusCount
    }
}

extension SettingsTableViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dismissKeyboard()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(row + 1) \(row == 0 ? "mile" : "miles")"
    }
}

extension SettingsTableViewController: SettingsModelDelegate {
    func dataDidUpdate(location: String?, selectRadius: Int) {
        defaultLocationTextField.text = location
        radiusPickerView.selectRow(selectRadius, inComponent: 0, animated: true)
    }

    func saveDidEnd() {
        let alert = UIAlertController(title: "Successfully saved ✅", message: nil, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
