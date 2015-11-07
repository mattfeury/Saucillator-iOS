//
//  ViewController.swift
//  Saucillator
//

import UIKit

class ViewController: UIViewController {

    let instrument = AKInstrument()
    let oscillator = AKOscillator()
    let freqProp = AKInstrumentProperty()
    let ampProp = AKInstrumentProperty()

    // Configurables are constant for now
    // HEYO! fixme
    let gridSize = 12
    let baseFreq = 440.0

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        instrument.play()
        for touch in touches {
            handleTouch(touch)
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            handleTouch(touch)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        instrument.stop()
    }

    func handleTouch(touch: UITouch) {
        let location = touch.locationInView(self.view)
        setAmplitude(location.x)
        setFrequency(location.y)
    }

    func setFrequency(currentY: CGFloat) {
        let offset = Double(self.view.bounds.height - currentY) / Double(self.view.bounds.height) * Double(gridSize)
        let frequency = Theory.getFrequencyForScaleNote(Theory.chromaticScale, baseFreq: baseFreq, offset: NSInteger(offset))
        freqProp.value = Float(frequency)
    }
    
    func setAmplitude(currentX: CGFloat) {
        let amplitude = Double(currentX) / Double(self.view.bounds.width)
        ampProp.value = Float(amplitude)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        oscillator.frequency = freqProp
        oscillator.amplitude = ampProp

        instrument.setAudioOutput(oscillator)
        AKOrchestra.addInstrument(instrument)
    }
}
