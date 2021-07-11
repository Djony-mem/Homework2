import UIKit

class ColorsConfiguratorViewController: UIViewController {
    @IBOutlet weak var currentColorView: UIView!

    @IBOutlet weak var redColorDisplay: UIView!
    @IBOutlet weak var greenColorDisplay: UIView!
    @IBOutlet weak var blueColorDisplay: UIView!

    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!

    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 20

        //Randomize initial slider values
        for slider in [redColorSlider, greenColorSlider, blueColorSlider] {
            slider?.value = Float.random(in: 0...1)
        }

        setColor()
        setValue(for: redColorValue, greenColorValue, blueColorValue)
        setColorDisplay(for: redColorSlider, greenColorSlider, blueColorSlider)
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        
        switch sender {
        case redColorSlider: setValue(for: redColorValue)
        case greenColorSlider: setValue(for: greenColorValue)
        default: setValue(for: blueColorValue)
        }
        setColorDisplay(for: sender)
        setColor()
    }
    private func setColor() {
        currentColorView.backgroundColor = UIColor(
            red: redColorSlider.value,
            green: greenColorSlider.value,
            blue: blueColorSlider.value
        )
    }
    
    private func setColorDisplay(for sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case redColorSlider:
                redColorDisplay.backgroundColor = UIColor(red: slider.value)
            case greenColorSlider:
                greenColorDisplay.backgroundColor = UIColor(green: slider.value)
            default:
                blueColorDisplay.backgroundColor = UIColor(blue: slider.value)
            }
        }
    }

    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorValue:
                label.text = calcColorStringValue(redColorSlider.value)
            case greenColorValue:
                label.text = calcColorStringValue(greenColorSlider.value)
            default:
                label.text = calcColorStringValue(blueColorSlider.value)
            }
        }
    }
    
    private func calcColorStringValue(_ value: Float) -> String {
        "\(round(value * 100) / 100)"
    }
}

extension UIColor {
    convenience init(red: Float = 0.0,
                     green: Float = 0.0,
                     blue: Float = 0.0,
                     alpha: Float = 1.0) {
        self.init(
            displayP3Red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha)
        )
    }
}

