//
//  SSCTestScoreService.swift
//  StrokeApp
//
//  Created by Mobile Guru on 4/24/15.
//  Copyright (c) 2015 Mobile Guru, Inc. All rights reserved.
//

import Foundation

import Mixpanel

class SSCTestScoreService: NSObject {
    
    let mixpanel = Mixpanel.sharedInstance(withToken: gMixpanelToken)
    
    let store = UserDefaults.standard
    let keyDataScores = "StrokeScaleCalculatorDataScores" //this holds the scores, init'd to 0
    let keyDataAnsweredScores = "StrokeScaleCalculatorDataScores" //same as keyDataScores except no init, so any unanswered score will not be in this dict
    let keyUncorrectedDataScores = "StrokeScaleCalculatorOriginalDataScores" //this holds the original scores for any that have been corrected
    let keyAnnotationsToDataScores = "StrokeScaleCalculatorAnnotationsToDataScores" //this holds annotations to each score
    let keyHasCorrectedScoresInternalFlag = "StrokeScaleCalculatorkeyHasCorrectedScoresInternalFlag"
    let keyIsGazeDeviated = "StrokeScaleCalculatorKeyIsGazeDeviated"
    let keyIsAbleToOpenEyes = "StrokeScaleCalculatorKeyIsAbleToOpenEyes"
    let keyHasVisualImpairment = "StrokeScaleCalculatorKeyHasVisualImpairment"
    let keyHasAphasia = "StrokeScaleCalculatorKeyHasAphasia"
    let keyCalculatorMode = "StrokeScaleCalculatorKeyCalculatorMode"
    let keyShouldNotifyOnAutoscore = "StrokeScaleCalculatorKeyShouldNotifyOnAutoscore"
    

    let question9ScoreComponents = "question9ScoreComponents"
    let key3APartialScore = "key3APartialScore"
    
    let GCSScoreKey = "GCSScoreKey"

    let keyGuardrailDidCompleteDict = "keyGuardrailDidCompleteDict"
    
    let storeFlowNumKey = "SSCTestScoreServiceFlowNumIntKey"

    
    let shouldForceAddNoteToContainContent = false
    
    let kModeCalculatorLearning = 1
    let kModeCalculatorAssisted = 2
    let kModeCalculatorExpert = 3
    private var modeCalculator:Int {
        get {
            let currMode = store.integer(forKey: keyCalculatorMode)
            if (currMode == 0) {
                store.set(kModeCalculatorLearning, forKey: keyCalculatorMode)
                return kModeCalculatorLearning
            }
            else {
                return currMode
            }
        }
        set {
            store.set(newValue, forKey: keyCalculatorMode)
        }
    }

    private var shouldNotifyOnAutoscore:Bool {
        get {
            return store.bool(forKey: keyShouldNotifyOnAutoscore)
        }
        set {
            store.set(newValue, forKey: keyShouldNotifyOnAutoscore)
        }
    }
    
    private var hasCorrectedScoresInternalFlag:Bool {
        get {
            return store.bool(forKey: keyHasCorrectedScoresInternalFlag)
        }
        set {
            store.set(newValue, forKey: keyHasCorrectedScoresInternalFlag)
        }
    }
    
    private var patientFlagIsGazeDeviated:Bool {
        get {
            return store.bool(forKey: keyIsGazeDeviated)
        }
        set {
            store.set(newValue, forKey: keyIsGazeDeviated)
        }
    }
    
    private var patientFlagIsAbleToOpenEyes:Bool {
        get {
            return store.bool(forKey: keyIsAbleToOpenEyes)
        }
        set {
            store.set(newValue, forKey: keyIsAbleToOpenEyes)
        }
    }
    
    private var patientFlagHasVisualImpairment:Bool {
        get {
            return store.bool(forKey: keyHasVisualImpairment)
        }
        set {
            store.set(newValue, forKey: keyHasVisualImpairment)
        }
    }
    
    private var patientFlagHasAphasia:Bool {
        get {
            return store.bool(forKey: keyHasAphasia)
        }
        set {
            store.set(newValue, forKey: keyHasAphasia)
        }
    }
    
    private var flowNum: Int {
        get {
            return store.integer(forKey: storeFlowNumKey)
        }
        set {
            store.set(newValue, forKey: storeFlowNumKey)
        }
    }
    
    private var dataScores: NSDictionary {
        get {
            return store.object(forKey: keyDataScores) as! NSDictionary
        }
        set {
            store.set(newValue, forKey: keyDataScores)
        }
    }

    private func setScoreInDataScores(newScore:String, questionNumberAsString:String) {
        let newScores = dataScores.mutableCopy() as! NSDictionary
        newScores.setValue(newScore, forKey: questionNumberAsString)
        dataScores = newScores
    }

    private var dataScoresUncorrected: NSDictionary {
        get {
            return store.object(forKey: keyUncorrectedDataScores) as! NSDictionary
        }
        set {
            store.set(newValue, forKey: keyUncorrectedDataScores)
        }
    }
    
    private func setScoreInDataScoresUncorrected(newScore:String, questionNumberAsString:String) {
        let newUncorrectedScores = dataScoresUncorrected.mutableCopy() as! NSDictionary
        newUncorrectedScores.setValue(newScore, forKey: questionNumberAsString)
        dataScoresUncorrected = newUncorrectedScores
    }
    
    private var dataAnnotationsToScores: NSDictionary {
        get {
            return store.object(forKey: keyAnnotationsToDataScores) as! NSDictionary
        }
        set {
            store.set(newValue, forKey: keyAnnotationsToDataScores)
        }
    }

    func setScoreAnnotation(newScoreAnnotation:String, questionNumberAsString:String) {
        let newDataAnnotationsToScores = dataAnnotationsToScores.mutableCopy() as! NSDictionary
        newDataAnnotationsToScores.setValue(newScoreAnnotation, forKey: questionNumberAsString)
        dataAnnotationsToScores = newDataAnnotationsToScores
    }

    var question9ScoreComponentsData: NSDictionary {
        get {
            return store.object(forKey: question9ScoreComponents) as! NSDictionary
        }
        set {
            store.set(newValue, forKey: question9ScoreComponents)
        }
    }
    
    var questionsOrderMaping = [[SCQType.Q1A.rawValue: "LOC (Level of consciousness)"]]
    required override init() {
        self.questionsOrderMaping.append(["1B": "LOC Questions"])
        self.questionsOrderMaping.append(["1C": "LOC Commands"])
        self.questionsOrderMaping.append(["2": "Best Gaze"])
        self.questionsOrderMaping.append(["3": "Visual Fields"])
        self.questionsOrderMaping.append(["4": "Facial Palsy"])
        self.questionsOrderMaping.append(["5A": "Left Arm"])
        self.questionsOrderMaping.append(["5B": "Right Arm"])
        self.questionsOrderMaping.append(["6A": "Left Leg"])
        self.questionsOrderMaping.append(["6B": "Right Leg"])
        self.questionsOrderMaping.append(["7": "Limb Ataxia"])
        self.questionsOrderMaping.append(["8": "Sensory"])
        self.questionsOrderMaping.append(["9": "Best Language"])
        self.questionsOrderMaping.append(["10": "Dysarthria"])
        self.questionsOrderMaping.append(["11": "Extinction & Neglect"])

        super.init()
    }
    
    func resetAllData() {
        let helpers = [keyDataScores, keyUncorrectedDataScores, keyAnnotationsToDataScores, question9ScoreComponents, key3APartialScore, GCSScoreKey, keyGuardrailDidCompleteDict, "Q11Skipped", "Q11ButtonType", "Q11aDoubleStimulation", "Q11bBestLanguage", "Annotations", "key3APartialScore"]
        for helper in helpers {
            store.set(nil, forKey: helper)
        }

//        self.setModeCalculator(kModeCalculatorLearning)  // DO NOT do this!
        self.hasCorrectedScoresInternalFlag = false
        
        self.setDefaultDictionaries()
        self.setFlowNumber(newFlowNumber: 0)
        self.setQ11EventButtonType(buttonType: 0)
        self.setQ11bBestLanguagePoints(points: 0)
        self.setQ11aDoubleStimulationPoints(points: 0)
        self.setQ11Skipped(newValue: false)
        self.patientFlagIsAbleToOpenEyes = false
        self.patientFlagHasVisualImpairment = false
        self.patientFlagIsGazeDeviated = false
        self.patientFlagHasAphasia = false
        
        self.resetAnnotations()
        
        resetGuardrailDidCompleteSettings()
        
        self.showDebuggingInfo()
    }
    
    func setDefaultDictionaries() {
        //This way will set the default values for the scores to 0.  We want to know if a question has been answered, and some of the methods below will return a default value for unanswered questions, so just use a blank dictionary instead.
//        var defaultDictionary: [String: AnyObject] = [ "0": 0 ]
//        for question in self.questionsOrderMaping {
//            let key = question.keys.first!
//            defaultDictionary[key] = 0
//        }
        dataScores = NSDictionary()

        dataScores = NSDictionary()

        question9ScoreComponentsData = ["1": 0, "2": 0, "3": 0]
        
        dataScoresUncorrected = NSDictionary()
        
        dataAnnotationsToScores = NSDictionary()
    }
    

    func getModeCalculator() -> Int {
        return self.modeCalculator
    }
    
    func setModeCalculator(newModeAsInt:Int) {
        self.modeCalculator = newModeAsInt
    }
    
    func hasPreviousEvidenceOfNegect()-> Bool{
        // DSS score == 1
        // OR score to expression of event == 1 ie: can't identify the 4 main events
        return self.getQ11aDoubleStimulationPoints() == 1 || self.getQ11bBestLanguagePoints() == 1;
    }
    
    //0 = normal, 1 = abnormal/oneEventButton
    func setQ11EventButtonType(buttonType: Int) {
        let newData = dataScores.mutableCopy() as! NSDictionary
        newData.setValue(buttonType, forKey: "Q11ButtonType")
        dataScores = newData
    }
    
    func getQ11EventButtonType() -> Int {
        return (dataScores.value(forKey: "Q11ButtonType") as! Int)
    }

    //TODO: Switch to Bool?
    func setQ11Skipped(newValue: Bool) {
        var newIntVal = 0
        if (newValue) { newIntVal = 1 }
        let newData = dataScores.mutableCopy() as! NSDictionary
        newData.setValue(newIntVal, forKey: "Q11Skipped")
        dataScores = newData
    }
    
    func isQ11Skipped() -> Bool {
        let returnIntVal = (dataScores.value(forKey: "Q11Skipped") as! Int)
        if (returnIntVal == 1) {
            return true
        }
        else {
            return false
        }
    }

    //NOTE: doubleStimulation == Q11A
    func setQ11aDoubleStimulationPoints(points: Int) {
        let newData = dataScores.mutableCopy() as! NSDictionary
        newData.setValue(points, forKey: "Q11aDoubleStimulation")
        dataScores = newData
    }
    
    func getQ11aDoubleStimulationPoints() -> Int {
        return (dataScores.value(forKey: "Q11aDoubleStimulation") as! Int)
    }

    func setQ11bBestLanguagePoints(points: Int) {
        let newData = dataScores.mutableCopy() as! NSDictionary
        newData.setValue(points, forKey: "Q11bBestLanguage")
        dataScores = newData
    }
    
    func getQ11bBestLanguagePoints() -> Int {
        return (dataScores.value(forKey: "Q11bBestLanguage") as! Int)
    }
    
    func setQ3APartialScoreAsFloat(score:Float) {
        store.set(score, forKey: key3APartialScore)
    }
    
    func setQ3APartialScoreWithString(score:String) {
        store.set(score, forKey: key3APartialScore)
    }
    
    func getQ3APartialScoreAsString() -> String {
        return store.string(forKey: key3APartialScore)!
    }
    
    //if not set, returns 0.0
    func getQ3APartialScoreAsFloat() -> Float {
        let outFloat:Float? = store.float(forKey: key3APartialScore)
        if (outFloat == nil) {
            return 0.0
        }
        else {
            return outFloat!
        }
    }
    
    func isPatientIntubated() -> Bool {
        return (getScoreAsIntForQuestionNumberAsString(questionNumber: "0") == 1)
    }
    
    func hasPatientComa() -> Bool {
        return (getScoreAsIntForQuestionNumberAsString(questionNumber: SCQType.Q1A.rawValue) == 3)
     }
    
    func setPatientIsAbleToOpenEyes(isAbleToOpenEyes:Bool) {
        self.patientFlagIsAbleToOpenEyes = isAbleToOpenEyes
    }
    func isPatientAbleToOpenEyes() -> Bool {
        return self.patientFlagIsAbleToOpenEyes
    }
    
    func setPatientHasVisualImpairment(hasVisualImpairment:Bool) {
        self.patientFlagHasVisualImpairment = hasVisualImpairment
    }
    func hasPatientVisualImpairment() -> Bool {
        return self.patientFlagHasVisualImpairment
    }

    func setIsGazeDeviated(isGazeDeviated:Bool){
        self.patientFlagIsGazeDeviated = isGazeDeviated
    }

    func isGazeDeviated() -> Bool {
        return self.patientFlagIsGazeDeviated
    }

    func setHasPatientAphasia(hasAphasia:Bool){
        self.patientFlagHasAphasia = hasAphasia
    }
    
    func hasPatientAphasia() -> Bool {
        return self.patientFlagHasAphasia
    }

    func getTotalScore() -> Int {
        var totalScore: Int = 0
        for question in self.questionsOrderMaping {
            for (key, _) in question {
                
                let valueInt = self.getScoreAsIntForQuestionNumberAsString(questionNumber: key)
                
                totalScore += valueInt
            }
        }
        return totalScore
    }
    
    func getTotalUncorrectedScore() -> Int {
        var totalScore: Int = 0
        for question in self.questionsOrderMaping {
            for (key, _) in question {
                totalScore += self.getUncorrectedScoreAsIntForQuestionNumberAsString(questionNumber: key)
            }
        }
        return totalScore
    }
    
    func scoreIsUNForQuestion(questionNumberAsString:String) -> Bool {
        let valueAsString:String? = dataScores.value(forKey: questionNumberAsString) as? String
        if (valueAsString == nil) {
            return false
        }
        else {
            if valueAsString!.hasPrefix("UN") {
                return true
            }
            else { return false }
        }
    }
    
    func patientHasUntestableLimbs() -> Bool {
//        return (((dataScores.valueForKey("6A") as? String) == "UN") || ((dataScores.valueForKey("6B") as? String) == "UN") || ((dataScores.valueForKey("5A") as? String) == "UN") || ((dataScores.valueForKey("5B") as? String) == "UN"))
        
        return ( (self.scoreIsUNForQuestion(questionNumberAsString: "6A")) || (self.scoreIsUNForQuestion(questionNumberAsString: "6B"))
            || (self.scoreIsUNForQuestion(questionNumberAsString: "5A")) || (self.scoreIsUNForQuestion(questionNumberAsString: "5B")) )
    }
    
    func listPatientHasUntestableLimbs() -> String {
        
        var stringList = String()
        
        stringList += self.scoreIsUNForQuestion(questionNumberAsString: "6A") ? " Left Leg " + self.getScoreAnnotationForQuestionNumAsString(questionNumberAsString: "6A") + ",": ""
        stringList += self.scoreIsUNForQuestion(questionNumberAsString: "6B") ? " Right Leg " + self.getScoreAnnotationForQuestionNumAsString(questionNumberAsString: "6B") + ",": ""
        stringList += self.scoreIsUNForQuestion(questionNumberAsString: "5A") ? " Left Arm " + self.getScoreAnnotationForQuestionNumAsString(questionNumberAsString: "5A") + ",": ""
        stringList += self.scoreIsUNForQuestion(questionNumberAsString: "5B") ? " Right Arm " + self.getScoreAnnotationForQuestionNumAsString(questionNumberAsString: "5B")  + ",": ""
        
        stringList = stringList.replacingOccurrences(of: "UN", with:"")
        stringList = String(stringList.characters.dropLast()) // drop last
        
        return stringList
    }
    
    //THIS IS NOT THE TOTAL SCORE!!!
    func setGCSScore(newVal:AnyObject) {
        store.set(newVal, forKey: GCSScoreKey)
    }
    
    func getGCSScore() -> Int {
        let scoreHash = store.object(forKey: GCSScoreKey) as! NSDictionary
        var score = 0
        for value in scoreHash.allValues {
            score += value as! Int
        }
        return score
    }

    func setQuestion9ScoreComponents(questionScore: NSDictionary) {
        let newData = question9ScoreComponentsData.mutableCopy() as! NSDictionary
        for key in questionScore.allKeys {
            newData.setValue(questionScore.value(forKey: key as! String) as! Int, forKey: key as! String)
        }
        question9ScoreComponentsData = newData
    }
    
    func setScoreFor9Question() {
        let scores = question9ScoreComponentsData as NSDictionary
        
        NSLog("question9ScoreComponentsData = \(question9ScoreComponentsData)")

        var totalScoreFor9Question = 0.0
        for score in scores.allValues {
            totalScoreFor9Question += score as! Double
        }
        var avgScore:Double = 0.0
        
        if self.hasPatientVisualImpairment() {
            avgScore = totalScoreFor9Question/2
        }
        else {
            avgScore = totalScoreFor9Question/3
        }

        //Use this for scoring, same ranges if div by 2 or div by 3
        //        TOTAL/3 = 0, Q9 score: 0 - go to screen 38
        //        TOTAL/3 = 0.01 to 1.5, Q9 score: 1 - go to screen 37
        //        TOTAL/3 = 1.6 to 2.4, Q9 score: 2 - go to screen 37
        //        TOTAL/3 = 2.4 to 3, Q9 score: 3 - go to screen 37
        var finalScore:Int = 0
        
        if      (avgScore < 0.01) { finalScore = 0 }
        else if (avgScore <= 1.5) { finalScore = 1 }
        else if (avgScore <= 2.4) { finalScore = 2 }
        else {                      finalScore = 3 }

        NSLog("Question 9 final score = \(finalScore)")

        setScoresForQuestions(dictionary: ["9": finalScore])
    
    }
    
    func getTotalQuestionNumber() -> Int {
        return questionsOrderMaping.count
    }
    
    
    func setScoresForQuestions(dictionary: NSDictionary) {
        let newDataScores = dataScores.mutableCopy() as! NSDictionary

        for key in dictionary.allKeys {
            newDataScores.setValue( dictionary.value(forKey: key as! String), forKey: key as! String)
        }
        dataScores = newDataScores

        showDebuggingInfo()
    }
    
    // MARK: - Calculate Q9 If Guardrail 6 is not triggered
    
    func setScoreForQ9(){
        
        var score = 0
        var totalScore = 0
        
        for item in SCQ9Type.allTypes {
            totalScore += self.getScoreAsIntForQuestionNumberAsString(questionNumber: item.rawValue)
        }        
        
        let div: Float = Float(totalScore) / 3.0
        
        if div == 0 {
            score = 0
        }else if div > 0 && div < 1.6 {
            score = 1
        }else if div <= 1.6 && div < 2.5 {
            score = 2
        }else if div <= 3 {
            score = 3
        }
        
        self.setScoresForQuestions(dictionary: [SCQType.Q9.rawValue: score])
    }
    
    // MARK: -
    
    func appendToScoreForQuestion(questionNumber:String, stringToAppend:String) {
        
        let trimmedNewString = trimStringOfWhitespace(stringToTrim: stringToAppend)
        
        if (trimmedNewString == "") {
            return
        }
        
        let trimmedOldString = trimStringOfWhitespace(stringToTrim: getScoreAsStringForQuestionNumberAsString(questionNumber: questionNumber))
        
        var combinedString = trimmedOldString
        
        if (trimmedOldString != "") {
            combinedString = "\(trimmedOldString); \(trimmedNewString)"
        }
        
        setScoreInDataScores(newScore: combinedString, questionNumberAsString: questionNumber)
    }
    
    func setCorrectedScoreForQuestion(questionNumAsString:String, correctedScore:String, reasonWhy:String) {
 
        if (questionNumAsString == "") { return }
        
        self.hasCorrectedScoresInternalFlag = true
        
        var oldScore:String? = getScoreAsStringForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: questionNumAsString)
        
        //first, record the old score as uncorrected score if there is an old score
        if (oldScore != nil) {
            setScoreInDataScoresUncorrected(newScore: oldScore!, questionNumberAsString:questionNumAsString)
        }
        else {
//            alertDLog("Setting corrected score for a score that has not yet been set? questionNumAsString = \(questionNumAsString) ")
            oldScore = "0"
            setScoresForQuestions(dictionary: ["1B": "0"])
            setScoreInDataScoresUncorrected(newScore: oldScore!, questionNumberAsString:questionNumAsString)
        }
        
        //next: set the new score
        setScoreInDataScores(newScore: correctedScore, questionNumberAsString: questionNumAsString)
        
        //finally, add an annotation to the score
        let trimmedReasonWhy = trimStringOfWhitespace(stringToTrim: reasonWhy)
        if (trimmedReasonWhy == "") {
            appendToScoreAnnotation(newScoreAnnotation: "Corrected from \(oldScore!) to \(correctedScore).", questionNumberAsString: questionNumAsString)
        }
        else {
            appendToScoreAnnotation(newScoreAnnotation: "Corrected from \(oldScore!) to \(correctedScore) because: \(trimmedReasonWhy)", questionNumberAsString: questionNumAsString)
        }
    }

    func getScoreAnnotationForQuestionNumAsString(questionNumberAsString:String) -> String {
        if (questionNumberAsString == "") {
            return ""
        }
        
        let value:AnyObject? = (dataAnnotationsToScores.value(forKey: questionNumberAsString) as AnyObject?)
        if (value == nil) {
            return ""
        }
        
        let valueAsString:String? = String(describing: value!)
        if (valueAsString == nil) {
            return ""
        }
        
        return valueAsString!

    }
    

    func getScoreWithAnnotationForQuestionNumAsString(questionNumberAsString:String) -> String {
        if (questionNumberAsString == "") { return "" }
        
        let scoreAsString = getScoreAsStringForQuestionNumberAsString(questionNumber: questionNumberAsString)
        let annotationAsString = getScoreAnnotationForQuestionNumAsString(questionNumberAsString: questionNumberAsString)
        
        if (annotationAsString == "") {
            return scoreAsString
        }
        else {
            return "\(scoreAsString) (\(annotationAsString))"
        }
    }
    

    func appendToScoreAnnotation(newScoreAnnotation:String, questionNumberAsString:String) {
        
        if ( (newScoreAnnotation == "") || (questionNumberAsString == "") ) {
            return
        }
        
        let newDataAnnotationsToScores = dataAnnotationsToScores.mutableCopy() as! NSDictionary
        
        let oldAnnotation:String? = newDataAnnotationsToScores.value(forKey: questionNumberAsString) as? String
        
        var newCombinedAnnotation = newScoreAnnotation
        
        if (oldAnnotation != nil) {
            newCombinedAnnotation = "\(oldAnnotation); \(newScoreAnnotation)"
        }
        
        setScoreAnnotation(newScoreAnnotation: newCombinedAnnotation, questionNumberAsString: questionNumberAsString)
    }
    

    func setFlowNumber(newFlowNumber: Int) {
        flowNum = newFlowNumber
        
        if (newFlowNumber != 0) {
            mixpanel.track("SSC-FlowNumber",
                properties: ["FlowNumber": "\(newFlowNumber)"]
            )
        }

        //TODO: debug fix
        showDebuggingInfo()
    }
    
    func getFlowNumber() -> Int {
        return flowNum
    }

    func resetAnnotations() {
        let newData = dataScores.mutableCopy() as! NSDictionary
        newData.setValue("", forKey: "Annotations")
        dataScores = newData
    }
    
    func getAnnotations() -> String {
        let annotations = dataScores.value(forKey: "Annotations") as! String
        return (annotations)
    }
    
    func appendToAnnotations(newString: String) {
        
        let trimmedNewString = trimStringOfWhitespace(stringToTrim: newString)
        
        if (trimmedNewString == "") {
            return
        }
        
        let newData = dataScores.mutableCopy() as! NSDictionary
        let oldString:NSString = dataScores.value(forKey: "Annotations") as! String as NSString
        
        let trimmedOldString = trimStringOfWhitespace(stringToTrim: oldString as String)

        var combinedString = ""
        
        if (trimmedOldString == "") {
            combinedString = trimmedNewString
        }
        else {
            combinedString = "\(oldString)\n\(trimmedNewString)"
        }
        
        newData.setValue(combinedString, forKey: "Annotations")
        dataScores = newData
    }
    
    //MARK: GuardRail Code

    //returns true if there is a need to show guardrails to the user
    func needsGuardrailNotifications () -> Bool {
        if (getNextGuardrailNumToDisplay() == 0) {
            return false
        }
        else {
            return true
        }
    }
    
    
    //returns nil for values that are not yet set
    func getScoreAsStringForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber:String) -> String? {
        if (questionNumber == "") {
            return nil
        }
        
        let value:AnyObject? = (dataScores.value(forKey: questionNumber) as AnyObject?)
        if (value == nil) {
            return nil
        }
        
        let valueAsString:String? = String(describing: value!)
        return valueAsString
    }
    
    
    
    //returns "" for values that are not yet set
    func getScoreAsStringForQuestionNumberAsString(questionNumber:String) -> String {
        
        let valueAsString:String? = getScoreAsStringForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: questionNumber)
        if (valueAsString == nil) {
            return ""
        }
        
        return valueAsString!
    }

    //returns nil for values that are not yet set
    func getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber:String) -> Int? {
        let valueAsString:String? = getScoreAsStringForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: questionNumber)
        
        if (valueAsString == nil) {
            return nil
        }

        let valueAsInt:Int? = Int(valueAsString!)
        
        if (valueAsInt == nil) {
            return nil
        }

        return valueAsInt
    }

    //returns 0 for values that have text labels instead of a number
    func getScoreAsIntForQuestionNumberAsString(questionNumber:String) -> Int {
        
        let valueAsOptionalInt:Int? = getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: questionNumber)

        if (valueAsOptionalInt == nil) {
            return 0
        }
        
        return valueAsOptionalInt!
    }
    
    //returns "0" for nil or empty string scores
    func getScoreStringWithZeroForEmptyFromString(scoreAsString:String?) -> String {
        if (scoreAsString == nil) { return "0" }
        else if (scoreAsString == "") { return "0" }
        else { return trimStringOfWhitespace(stringToTrim: scoreAsString!) }
    }

    //returns true if there is at least one score that has been corrected
    func hasCorrectedScores() -> Bool {
        return self.hasCorrectedScoresInternalFlag
    }

    //returns "" for questions that don't have a score, and returns the score if there's no uncorrected score
    func getUncorrectedScoreAsStringForQuestionNumberAsString(questionNumber:String) -> String {
        if (questionNumber == "") {
            return ""
        }
        
        //first look for an uncorrected score
        let uncorrectedValue:AnyObject? = (dataScoresUncorrected.value(forKey: questionNumber) as AnyObject?)
        if (uncorrectedValue != nil) {
            let uncorrectedValueAsString = String(describing: uncorrectedValue!)
            return uncorrectedValueAsString
        }
        else {
            //no uncorrected score, so look for a current score, return 0 if none
            let currentScoreValue:AnyObject? = (dataScores.value(forKey: questionNumber) as AnyObject?)
            
            if (currentScoreValue == nil) {
                return ""
            }
            else {
                let currentScoreAsString = String(describing: currentScoreValue!)
                return currentScoreAsString
            }
        }
    }
    
    //returns the uncorrected score (if it exists), else the current score for any scores that exist.  Returns 0 for any questions that do not have scores
    func getUncorrectedScoreAsIntForQuestionNumberAsString(questionNumber:String) -> Int {
        
        let uncorrectedScoreAsString = self.getUncorrectedScoreAsStringForQuestionNumberAsString(questionNumber: questionNumber)
        
        if (uncorrectedScoreAsString == "") {
            return 0
        }
        else {
            let valueAsInt:Int? = Int(uncorrectedScoreAsString)
            
            if (valueAsInt == nil) {
                return 0
            }
            
            return valueAsInt!
        }
    }

    
    
    //returns 0 for no next guardrail to display
    func getNextGuardrailNumToDisplay() -> Int {
        /// Lie's debugging playground:
//
//        if ( !getGuardraiDidCompleteGuardrailNumber(5) ) {
//            return 5
//        }
//        if ( !getGuardraiDidCompleteGuardrailNumber(6) ) {
//            return 6
//        }
//        if ( !getGuardraiDidCompleteGuardrailNumber(7) ) {
//            return 7
//        }
//        return 0  //uncomment this and set to a question number to force a guardrail to appear for debugging/testing
//
        
        
        if ( !getGuardraiDidCompleteGuardrailNumber(guardrailNumber: 1) ) {
//            - Please note that his guardrail is triggered only if the sum of Q1b + Q1c is equal to or greater than 2.
//            - The value of Q1a is NOT added into the value that triggers the checkpoint.  However, the value of Q1a DOES determine the flow and therefore plays a role in whether the checkpoint will show up (i.e., the only place that guardrail 1 can exist is in Flow 3 and 4, which are determined by scoring a 0 or 1 in Q1a.  The stuporous & comatose patient will not require this checkpoint to be present)
            let flowNumber = self.getFlowNumber()
            if ( (flowNumber == 3) ) {
                
                //Need to have an answer to 1C
                
                let score1BValue:Int? = getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: "1B")
                let score1CValue:Int? = getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: "1C")
                if ( (score1BValue != nil) && (score1CValue != nil) ) {
                    let combinedScore = score1BValue! + score1CValue!
                    if ( combinedScore > 1) {
                        return 1
                    }
                }
            }
        }/*
        if ( !getGuardraiDidCompleteGuardrailNumber(2) ) {
            if (self.getModeCalculator() < self.kModeCalculatorExpert) {

//           Should be triggered if the patient receives a score of 2 or 3 for Q9
//            AND
//            the provider has scored 0 or 1 for Q1B.
                let score9Value = getScoreAsIntForQuestionNumberAsString("9")
                if ( (score9Value == 2) || (score9Value == 3) ) {
                    let score1BValue = getScoreAsIntForQuestionNumberAsString("1B")
                    if ( (score1BValue == 0) || (score1BValue == 1) ) {
                        
                        return 2
                    }
                }
            }
        }*/
   /*     if ( !getGuardraiDidCompleteGuardrailNumber(3) ) {
            if (self.getModeCalculator() < self.kModeCalculatorExpert) {

//            Should be triggered if the patient receives a score of 2 or 3 for Q9
//                AND
//            the provider has scored 1 or 2 for Q7.
                let score9Value = getScoreAsIntForQuestionNumberAsString("9")
                if ( (score9Value == 2) || (score9Value == 3) ) {
                    let score7Value = getScoreAsIntForQuestionNumberAsString("7")
                    if ( (score7Value == 1) || (score7Value == 2) ) {
                        return 3
                    }
                }
            }
        }*/
        if ( !getGuardraiDidCompleteGuardrailNumber(guardrailNumber: 4) ) {
            if (self.getModeCalculator() < self.kModeCalculatorExpert) {

//            Should be triggered if the patient receives a score of 2 or 3 for Q9
//                AND
//            the provider has scored 2 for Q8.
                let flowNumber = self.getFlowNumber()
                if ( (flowNumber != 1) && (flowNumber != 2) ) {
                    let score9Value = getScoreAsIntForQuestionNumberAsString(questionNumber: "9")
                    if ( (score9Value == 2) || (score9Value == 3) ) {
                        let score8Value = getScoreAsIntForQuestionNumberAsString(questionNumber: "8")
                        if ( (score8Value == 2) ) {
                            return 4
                        }
                    }
                }
            }
        }
        
        /* Guardrails 5 & 6 are comprimised by Question 5
        
        if ( !getGuardraiDidCompleteGuardrailNumber(5) ) {
//            IF
//            Q4 = 1, 2 or 3
//            or
//            Q5a = 1,2,3, or 4
//            or
//            Q6a = 1,2,3 or 4
//            AND
//            Q9 = 1,2 or 3
            let flowNumber = self.getFlowNumber()
            if ( (flowNumber != 1) && (flowNumber != 2) ) {
                let score4Value = getScoreAsIntForQuestionNumberAsString("4")
                let score5AValue = getScoreAsIntForQuestionNumberAsString("5A")
                let score6AValue = getScoreAsIntForQuestionNumberAsString("6A")
                if ((score4Value == 1) || (score4Value == 2) || (score4Value == 3)
                    ||  (score5AValue == 1) || (score5AValue == 2) || (score5AValue == 3) || (score5AValue == 4)
                    ||  (score6AValue == 1) || (score6AValue == 2) || (score6AValue == 3) || (score6AValue == 4)
                    ) {
                        let score9Value = getScoreAsIntForQuestionNumberAsString("9")
                        if ( (score9Value == 1) || (score9Value == 2) || (score9Value == 3) ) {
                            return 5
                        }
                }
            }
        }
        if ( !getGuardraiDidCompleteGuardrailNumber(6) ) {
//                            IF
//                            Q4 = 1, 2 or 3
//                            or
//                            Q5b = 1,2,3, or 4
//                            or
//                            Q6b = 1,2,3 or 4
//                            AND
//                            Q11 = 1 or 2
            let flowNumber = self.getFlowNumber()
            if ( (flowNumber != 1) && (flowNumber != 2) ) {
                
                let score4Value = getScoreAsIntForQuestionNumberAsString("4")
                let score5BValue = getScoreAsIntForQuestionNumberAsString("5B")
                let score6BValue = getScoreAsIntForQuestionNumberAsString("6B")
                if ((score4Value == 1) || (score4Value == 2) || (score4Value == 3)
                    ||  (score5BValue == 1) || (score5BValue == 2) || (score5BValue == 3) || (score5BValue == 4)
                    ||  (score6BValue == 1) || (score6BValue == 2) || (score6BValue == 3) || (score6BValue == 4)
                    ) {
                        let score11Value = getScoreAsIntForQuestionNumberAsString("11")
                        if ( (score11Value == 1) || (score11Value == 2) ) {
                            return 6
                        }
                }
            }
        }
*/
        
        
        if ( !getGuardraiDidCompleteGuardrailNumber(guardrailNumber: 7) ) {
//            If Q9 = 1, 2 or 3
//            AND Q11 = 1 or 2
//            Guardrail 7 can be ignored in Flow 1,2,5,6
            let flowNumber = self.getFlowNumber()
            if ( (flowNumber != 1) && (flowNumber != 2) && (flowNumber != 5) && (flowNumber != 6) ) {
                let score9Value = getScoreAsIntForQuestionNumberAsString(questionNumber: "9")
                if ( (score9Value == 1) || (score9Value == 2) || (score9Value == 3) ) {
                    let score11Value = getScoreAsIntForQuestionNumberAsString(questionNumber: "11")
                    if ( (score11Value == 1) || (score11Value == 2) ) {
                        return 7
                    }
                }
            }
        }
        if ( !getGuardraiDidCompleteGuardrailNumber(guardrailNumber: 8) ) {
            if (self.getModeCalculator() < self.kModeCalculatorExpert) {
                
//            Q1c = Obeys both commmands while stuporous
//            In Flow 5 and 6, the guardrail should get triggered if a user taps Score 0 (OBEYS BOTH)
                let flowNumber = self.getFlowNumber()
                if ( (flowNumber == 5) || (flowNumber == 6) ) {
                    let score1CValue:Int? = getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: "1C")
                    if (score1CValue != nil) {
                        if ( (score1CValue == 0) ) {
                            return 8
                        }
                    }
                }
            }
        }
        
        if ( !getGuardraiDidCompleteGuardrailNumber(guardrailNumber: 9) ) {
            if (self.getModeCalculator() < self.kModeCalculatorExpert) {
//            FLOW 4
//                - Please note that his guardrail is NOT triggered only if the sum of Q1b + Q1c is equal to or greater than 2.  If Q1C is scored a 1 or 2, this guardrail is triggered
                let flowNumber = self.getFlowNumber()
                if ( (flowNumber == 4) ) {
                    let score1CValue:Int? = getScoreAsIntForQuestionNumberAsStringReturnsNilForUnansweredQuestions(questionNumber: "1C")
                    if (score1CValue != nil) {
                        if ( (score1CValue == 1) || (score1CValue == 2) ) {
                            return 9
                        }
                    }
                }
            }
        }
        
        
//        if ( !getGuardraiDidCompleteGuardrailNumber(98) ) {
//            if (shouldShowGuardrailDebugInfo) {
//                return 98
//            }
//        }
//        if ( !getGuardraiDidCompleteGuardrailNumber(99) ) {
//            if (shouldShowGuardrailDebugInfo) {
//                return 99
//            }
//        }

        
        //if nothing above triggered, return 0 to indicate no next guardrail
        return 0
    }
    
    func getGuardraiDidCompleteGuardrailNumber(guardrailNumber: Int) -> Bool {
        var didCompleteDict:NSDictionary? = store.dictionary(forKey: keyGuardrailDidCompleteDict) as NSDictionary?
        if (didCompleteDict == nil) {
//            alertDLog("FIX ME:  This should never be here!!!  #1512031506")
            resetGuardrailDidCompleteSettings()
            didCompleteDict = NSDictionary()
        }
        
        var didCompleteForSpecifiedNumber:NSNumber? = didCompleteDict!.value(forKey: "\(guardrailNumber)") as? NSNumber
        
        if (didCompleteForSpecifiedNumber == nil) {
            didCompleteForSpecifiedNumber = NSNumber(value: false)
        }
        
        if (didCompleteForSpecifiedNumber!.boolValue == true) {
            return true
        }
        else {
            return false
        }
    }
    
    func setGuardrailDidCompleteGuardrailNumber(guardrailNumber: Int) {
        let completedDict = store.dictionary(forKey: keyGuardrailDidCompleteDict)!
        let completedMutableDict = NSMutableDictionary(dictionary: completedDict)
        completedMutableDict.setValue(NSNumber(value: true), forKey:"\(guardrailNumber)")
        store.set(completedMutableDict, forKey: keyGuardrailDidCompleteDict)
    }
    
    func resetGuardrailDidCompleteSettings () {
        store.set(NSDictionary(), forKey: keyGuardrailDidCompleteDict)
    }

    func shouldAlertUserOnAutoscore() -> Bool {
        return self.shouldNotifyOnAutoscore
    }
    
    func getHTMLVersionOfScoresAndAnnotations() -> String {
        
        let tableHTML:NSMutableString = ""
        
        if (self.hasCorrectedScores()) {
            tableHTML.append("<body><div> <h2>\(gStrokeAppCalculatorTitle)<br/>Total Corrected Score: \(self.getTotalScore()) | Total Uncorrected Score:  \(self.getTotalUncorrectedScore())</h2> </div><div style='overflow-x:auto; overflow-y:auto;' > <table><thead><th>#</th><th>Question</th><th>Uncorrected Score</th><th>Corrected Score</th><th>Notes</th></thead><tbody>")
        }
        else {
            tableHTML.append("<body><div> <h2>\(gStrokeAppCalculatorTitle)<br/>Total Score: \(self.getTotalScore()) </h2></div><div style='overflow-x:auto; overflow-y:auto;' > <table><thead><th>#</th><th>Question</th><th>Score</th><th>Notes</th></thead><tbody>")
        }
        
        for question in self.questionsOrderMaping {
            for (key, value) in question {
                tableHTML.append("<tr>\n")
                tableHTML.append("<td>\(key) </td>\n") //Question #
                tableHTML.append("<td>\(value) </td>\n") //Question Description
                tableHTML.append("<td>\(self.getUncorrectedScoreAsStringForQuestionNumberAsString(questionNumber: key)) </td>\n") //Uncorrected Score
                if (self.hasCorrectedScores()) {
                    tableHTML.append("<td>\(self.getScoreAsStringForQuestionNumberAsString(questionNumber: key)) </td>") //Corrected Score
                }
                tableHTML.append("<td>\(self.getScoreAnnotationForQuestionNumAsString(questionNumberAsString: key)) </td>") //Annotations
                tableHTML.append("</tr>")
            }
        }

        tableHTML.append("</tbody></table></div>")

        let annotationsAsStringWithNewlines = trimStringOfWhitespace(stringToTrim: self.getAnnotations())
        
        if (annotationsAsStringWithNewlines != "") {
            let annotationsAsHTMLString = annotationsAsStringWithNewlines.replacingOccurrences(of: "\n", with: " <br/>\n")
            
            tableHTML.append("\n<div style='text-align: left'><h2>Notes:</h2>\n\(annotationsAsHTMLString)</div><br/><br/>\n")
        }
        
        tableHTML.append("\n</body>\n")

        NSLog("tableHTML = \(tableHTML)")
        
        return String(tableHTML)
    }

    
    func getTextVersionOfScoresAndAnnotations() -> String {
        let outMutableString:NSMutableString = NSMutableString(string: "\(gStrokeAppCalculatorTitle)\n")

        if hasCorrectedScores() {
            outMutableString.append("\nTotal Corrected Score:   \(getTotalScore())\n")
            outMutableString.append("\nTotal Uncorrected Score: \(getTotalUncorrectedScore())\n")
            outMutableString.append("\n*************************\n")
            outMutableString.append("Corrected Scores:\n\n")
        }
        else {
            outMutableString.append("\nTotal Score: \(getTotalScore())\n")
            outMutableString.append("\n*************************\n")
            outMutableString.append("Scores:\n\n")
        }
        
        for questionPair in self.questionsOrderMaping {
            for (key, description) in questionPair {
                
                let valueAsString = getScoreAsStringForQuestionNumberAsString(questionNumber: key)
                
                outMutableString.append("\(key) - \(description):\t\(valueAsString)")

                let annotationAsString = getScoreAnnotationForQuestionNumAsString(questionNumberAsString: key)
                
                if (annotationAsString != "") {
                    outMutableString.append(" (\(annotationAsString))")
                }
                
                outMutableString.append("\n")
            }
        }
        
        if hasCorrectedScores() {
            outMutableString.append("\n*************************\n")
            outMutableString.append("Original (uncorrected) scores:\n\n")

            for questionPair in self.questionsOrderMaping {
                for (key, description) in questionPair {
                    
                    let valueAsString = getUncorrectedScoreAsStringForQuestionNumberAsString(questionNumber: key)
                    
                    outMutableString.append("UNCORRECTED: \(key) - \(description):\t\(valueAsString)")
                    
                    outMutableString.append("\n")
                }
            }
        }
        
        outMutableString.append("\n*************************\n")
        let annotations = getAnnotations()
        outMutableString.append("Notes:\n\n\(annotations)\n")

        var shouldShowDebugInfo = false
        shouldShowDebugInfo = gStrokeAppGlobalDEBUG //this removes the var vs. let warning in release builds
        
        #if DEBUG
            shouldShowDebugInfo = true
        #endif
        
        if (shouldShowDebugInfo) {
            outMutableString.append("\n*************************\n\n")
            let flowNumber = self.getFlowNumber()
            outMutableString.append("DEBUG:\n")
            outMutableString.append("Flow Number: \(flowNumber)\n")
        }
        
        NSLog("\(outMutableString)")
        return outMutableString as String
    }
    
    //MARK: debug functions
    func showDebuggingInfo() {
        NSLog("FLOW: = \(getFlowNumber())")
        NSLog("dataScores = \(dataScores)")
        NSLog("dataScoresUncorrected = \(dataScoresUncorrected)")
        NSLog("dataAnnotationsToScores = \(dataAnnotationsToScores)")
    }
}
