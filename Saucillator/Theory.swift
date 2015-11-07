//
//  Theory.swift
//  Saucillator
//
//  Created by Matt Feury on 11/6/15.
//  Copyright © 2015 AudioKit. All rights reserved.
//

import Foundation

class Theory {
    static let chromaticScale = [0,1,2,3,4,5,6,7,8,9,10,11]
    let majorScale = [0,2,4,5,7,9,11]
    let minorScale = [0,2,3,5,7,8,10]
    let minorBluesScale = [0,3,5,6,7,10,12]
    let pentatonicScale = [0,3,5,7,10,12]

    static let A1 = 55.0

    static func getFrequencyForNote(note: NSInteger, octave: NSInteger) -> Double {
        let noteFreq = A1 * pow(2.0, (Double(note) - 1.0) / 12.0)
        return noteFreq * pow(2.0, Double(octave) - 1.0)
    }

    static func getFrequencyForScaleNote(scale: [Int], baseFreq: Double, offset: NSInteger) -> Double {
        let scaleOffset = getScaleIntervalFromOffset(scale, offset: offset)
        return pow(2.0, Double(scaleOffset) / 12.0) * baseFreq
    }

    static func getScaleIntervalFromOffset(scale: [Int], offset: NSInteger) -> NSInteger {
        return scale[abs(offset) % scale.count] + 12 * offset / scale.count;
    }
}