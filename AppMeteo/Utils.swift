//
//  Utils.swift
//  AppMeteo
//
//  Created by tplocal on 11/03/2023.
//

import Foundation


func formatDate(timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    return dateFormatter.string(from: date)
}

func formatHeure(timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: date)
}

func getBackgroundImageName(for iconCode: String) -> String {
    switch iconCode {
    case "01d":
        return "backgroundClearDay.png"
    case "01n":
        return "backgroundClearNight.png"
    case "02d":
        return "backgroundFewCloudsDay.png"
    case "02n":
        return "backgroundFewCloudsNight.png"
    case "03d", "03n":
        return "backgroundCloud.png"
    case "04d", "04n":
        return "backgroundBrokenClouds.png"
    case "09d", "09n":
        return "backgroundShowerRain.png"
    case "10d":
        return "backgroundRainDay.png"
    case "10n":
        return "backgroundRainNight.png"
    case "11d", "11n":
        return "backgroundThunderstorm.png"
    case "13d", "13n":
        return "backgroundSnow.png"
    case "50d", "50n":
        return "backgroundMist.png"
    default:
        return "backgroundDefault.png"
    }
}
func getBackgroundImage(for iconCode: String) -> String {
    switch iconCode {
    case "01d":
        return "backgroundDay.png"
    case "01n":
        return "backgroundNight.png"
    case "02d":
        return "backgroundDay.png"
    case "02n":
        return "backgroundNight.png"
    case "03d", "03n":
        return "backgroundDay.png"
    case "04d", "04n":
        return "backgroundDay.png"
    case "09d", "09n":
        return "backgroundDay.png"
    case "10d":
        return "backgroundDay.png"
    case "10n":
        return "backgroundNight.png"
    case "11d", "11n":
        return "backgroundDay.png"
    case "13d", "13n":
        return "backgroundDay.png"
    case "50d":
        return "backgroundDay.png"
    case "50n":
        return "backgroundNight.png"
    default:
        return "backgroundDay.png"
    }
}

func windDirectionFromDegree(degree: Int) -> String {
    switch degree {
        case 0...22, 338...360:
            return "Nord"
        case 23...67:
            return "Nord-Est"
        case 68...112:
            return "Est"
        case 113...157:
            return "Sud-Est"
        case 158...202:
            return "Sud"
        case 203...247:
            return "Sud-Ouest"
        case 248...292:
            return "Ouest"
        case 293...337:
            return "Nord-Ouest"
        default:
            return "Inconnue"
    }
}
