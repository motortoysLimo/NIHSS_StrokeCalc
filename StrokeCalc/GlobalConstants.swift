//App-WideConstants

//MARK: Global Constants
//TODO: Production: turn off debug flag!!!!
let gStrokeAppGlobalDEBUG = false
//let gStrokeAppGlobalDEBUG = true

//MARK: strings
let gStrokeAppCalculatorTitle = "StrokeApp™ NIHSS Calculator" //"NIH StrokeApp™ Calculator"

//MARK: Closures

typealias gClosureGeneric = (() -> Void)
//typealias gClosureButton = ((sender: UIButton) -> Void)

//MARK: Fonts
//Available fonts: "Academy Engraved LET", "Al Nile", "American Typewriter", "Apple Color Emoji", "Apple SD Gothic Neo", "Arial", "Arial Hebrew", "Arial Rounded MT Bold", "Avenir", "Avenir Next", "Avenir Next Condensed", "Bangla Sangam MN", "Baskerville", "Bodoni 72", "Bodoni 72 Oldstyle", "Bodoni 72 Smallcaps", "Bodoni Ornaments", "Bradley Hand", "Chalkboard SE", "Chalkduster", "Cochin", "Copperplate", "Courier", "Courier New", "Damascus", "Devanagari Sangam MN", "Didot", "Euphemia UCAS", "Farah", "Futura", "Geeza Pro", "Georgia", "Gill Sans", "Gujarati Sangam MN", "Gurmukhi MN", "Heiti SC", "Heiti TC", "Helvetica", "Helvetica Neue", "Hiragino Mincho ProN", "Hiragino Sans", "Hoefler Text", "Iowan Old Style", "Kailasa", "Kannada Sangam MN", "Khmer Sangam MN", "Kohinoor Bangla", "Kohinoor Devanagari", "Kohinoor Telugu", "Lao Sangam MN", "Malayalam Sangam MN", "Marker Felt", "Menlo", "Mishafi", "Noteworthy", "Optima", "Oriya Sangam MN", "Palatino", "Papyrus", "Party LET", "PingFang HK", "PingFang SC", "PingFang TC", "Savoye LET", "Sinhala Sangam MN", "Snell Roundhand", "Symbol", "Tamil Sangam MN", "Telugu Sangam MN", "Thonburi", "Times New Roman", "Trebuchet MS", "Verdana", "Zapf Dingbats", "Zapfino",

//Available fonts for "Avenir": "Avenir-Black", "Avenir-BlackOblique", "Avenir-Book", "Avenir-BookOblique", "Avenir-Heavy", "Avenir-HeavyOblique", "Avenir-Light", "Avenir-LightOblique", "Avenir-Medium", "Avenir-MediumOblique", "Avenir-Oblique", "Avenir-Roman"

//Available fonts for "Avenir Next":  "AvenirNext-Bold", "AvenirNext-BoldItalic", "AvenirNext-DemiBold", "AvenirNext-DemiBoldItalic", "AvenirNext-Heavy", "AvenirNext-HeavyItalic", "AvenirNext-Italic", "AvenirNext-Medium", "AvenirNext-MediumItalic", "AvenirNext-Regular", "AvenirNext-UltraLight", "AvenirNext-UltraLightItalic"

//TODO: replace this throught the file:  hard-coded fonts to use global constants

let gFontSANormalName = "AvenirNext-Regular"
let gFontSABoldName = "AvenirNext-Bold"


//MARK: Colors
//Mark: See file: Views>UIComponents>baseColors.swift

//MARK: functions
func trimStringOfWhitespace(stringToTrim:String) -> String {
    let trimmedNewString = stringToTrim.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmedNewString
}
//func trimStringOfWhitespace(stringToTrim:String) -> String {
//    let stringToTrimAsNSString = NSString(string: stringToTrim)
//    let trimmedNewString = stringToTrimAsNSString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//    return String(trimmedNewString)
//}


//MARK: Mixpanel
let gMixpanelToken = "1d179c4a41a774d27ce3a62657223a9f"

