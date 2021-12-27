//
//  Time.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 27/12/2021.
//

import Foundation

struct Time {
    let hour: Int
    let minute: Int

    init?(hour: Int, minute: Int) {
        guard hour >= 0, hour < 24, minute >= 0, minute < 60 else {
            return nil
        }

        self.hour = hour
        self.minute = minute
    }
}
