//
//  KeyCodes.swift
//
//  Created by Zakk Hoyt on 12/23/17.
//  Copyright © 2017 Zakk Hoyt. All rights reserved.
//
//
//  These key code constants are wrappers around Carbon's
//  <HIToolbox/Events.h> header file. This just provides
//  swifty syntax sugar. Think of it as "NSKeyCodes".

import Carbon

public struct KeyCode {
    
    public typealias RawType = UInt16
    
    public static let a = UInt16(kVK_ANSI_A)
    public static let b = UInt16(kVK_ANSI_B)
    public static let c = UInt16(kVK_ANSI_C)
    public static let d = UInt16(kVK_ANSI_D)
    public static let e = UInt16(kVK_ANSI_E)
    public static let f = UInt16(kVK_ANSI_F)
    public static let g = UInt16(kVK_ANSI_G)
    public static let h = UInt16(kVK_ANSI_H)
    public static let i = UInt16(kVK_ANSI_I)
    public static let j = UInt16(kVK_ANSI_J)
    public static let k = UInt16(kVK_ANSI_K)
    public static let l = UInt16(kVK_ANSI_L)
    public static let m = UInt16(kVK_ANSI_M)
    public static let n = UInt16(kVK_ANSI_N)
    public static let o = UInt16(kVK_ANSI_O)
    public static let p = UInt16(kVK_ANSI_P)
    public static let q = UInt16(kVK_ANSI_Q)
    public static let r = UInt16(kVK_ANSI_R)
    public static let s = UInt16(kVK_ANSI_S)
    public static let t = UInt16(kVK_ANSI_T)
    public static let u = UInt16(kVK_ANSI_U)
    public static let v = UInt16(kVK_ANSI_V)
    public static let w = UInt16(kVK_ANSI_W)
    public static let x = UInt16(kVK_ANSI_X)
    public static let y = UInt16(kVK_ANSI_Y)
    public static let z = UInt16(kVK_ANSI_Z)
    
    public static let number0 = UInt16(kVK_ANSI_0)
    public static let number1 = UInt16(kVK_ANSI_1)
    public static let number2 = UInt16(kVK_ANSI_2)
    public static let number3 = UInt16(kVK_ANSI_3)
    public static let number4 = UInt16(kVK_ANSI_4)
    public static let number5 = UInt16(kVK_ANSI_5)
    public static let number6 = UInt16(kVK_ANSI_6)
    public static let number7 = UInt16(kVK_ANSI_7)
    public static let number8 = UInt16(kVK_ANSI_8)
    public static let number9 = UInt16(kVK_ANSI_9)
    
    public static let keypad0 = UInt16(kVK_ANSI_Keypad0)
    public static let keypad1 = UInt16(kVK_ANSI_Keypad1)
    public static let keypad2 = UInt16(kVK_ANSI_Keypad2)
    public static let keypad3 = UInt16(kVK_ANSI_Keypad3)
    public static let keypad4 = UInt16(kVK_ANSI_Keypad4)
    public static let keypad5 = UInt16(kVK_ANSI_Keypad5)
    public static let keypad6 = UInt16(kVK_ANSI_Keypad6)
    public static let keypad7 = UInt16(kVK_ANSI_Keypad7)
    public static let keypad8 = UInt16(kVK_ANSI_Keypad8)
    public static let keypad9 = UInt16(kVK_ANSI_Keypad9)
    public static let keypadClear = UInt16(kVK_ANSI_KeypadClear)
    public static let keypadDivide = UInt16(kVK_ANSI_KeypadDivide)
    public static let keypadEnter = UInt16(kVK_ANSI_KeypadEnter)
    public static let keypadEquals = UInt16(kVK_ANSI_KeypadEquals)
    public static let keypadMinus = UInt16(kVK_ANSI_KeypadMinus)
    public static let keypadPlus = UInt16(kVK_ANSI_KeypadPlus)
    public static let pageDown = UInt16(kVK_PageDown)
    public static let pageUp = UInt16(kVK_PageUp)
    public static let end = UInt16(kVK_End)
    public static let home = UInt16(kVK_Home)
    
    public static let f1 = UInt16(kVK_F1)
    public static let f2 = UInt16(kVK_F2)
    public static let f3 = UInt16(kVK_F3)
    public static let f4 = UInt16(kVK_F4)
    public static let f5 = UInt16(kVK_F5)
    public static let f6 = UInt16(kVK_F6)
    public static let f7 = UInt16(kVK_F7)
    public static let f8 = UInt16(kVK_F8)
    public static let f9 = UInt16(kVK_F9)
    public static let f10 = UInt16(kVK_F10)
    public static let f11 = UInt16(kVK_F11)
    public static let f12 = UInt16(kVK_F12)
    public static let f13 = UInt16(kVK_F13)
    public static let f14 = UInt16(kVK_F14)
    public static let f15 = UInt16(kVK_F15)
    public static let f16 = UInt16(kVK_F16)
    public static let f17 = UInt16(kVK_F17)
    public static let f18 = UInt16(kVK_F18)
    public static let f19 = UInt16(kVK_F19)
    public static let f20 = UInt16(kVK_F20)
    
    public static let apostrophe = UInt16(kVK_ANSI_Quote)
    public static let backApostrophe = UInt16(kVK_ANSI_Grave)
    public static let backslash = UInt16(kVK_ANSI_Backslash)
    public static let capsLock = UInt16(kVK_CapsLock)
    public static let comma = UInt16(kVK_ANSI_Comma)
    public static let help = UInt16(kVK_Help)
    public static let forwardDelete = UInt16(kVK_ForwardDelete)
    public static let decimal = UInt16(kVK_ANSI_KeypadDecimal)
    public static let delete = UInt16(kVK_Delete)
    public static let equals = UInt16(kVK_ANSI_Equal)
    public static let escape = UInt16(kVK_Escape)
    public static let leftBracket = UInt16(kVK_ANSI_LeftBracket)
    public static let minus = UInt16(kVK_ANSI_Minus)
    public static let multiply = UInt16(kVK_ANSI_KeypadMultiply)
    public static let period = UInt16(kVK_ANSI_Period)
    public static let `return` = UInt16(kVK_Return)
    public static let rightBracket = UInt16(kVK_ANSI_RightBracket)
    public static let semicolon = UInt16(kVK_ANSI_Semicolon)
    public static let slash = UInt16(kVK_ANSI_Slash)
    public static let space = UInt16(kVK_Space)
    public static let tab = UInt16(kVK_Tab)
    
    public static let mute = UInt16(kVK_Mute)
    public static let volumeDown = UInt16(kVK_VolumeDown)
    public static let volumeUp = UInt16(kVK_VolumeUp)
    
    public static let command = UInt16(kVK_Command)
    public static let rightCommand = UInt16(kVK_RightCommand)
    public static let control = UInt16(kVK_Control)
    public static let rightControl = UInt16(kVK_RightControl)
    public static let function = UInt16(kVK_Function)
    public static let option = UInt16(kVK_Option)
    public static let rightOption = UInt16(kVK_RightOption)
    public static let shift = UInt16(kVK_Shift)
    public static let rightShift = UInt16(kVK_RightShift)
    
    public static let downArrow = UInt16(kVK_DownArrow)
    public static let leftArrow = UInt16(kVK_LeftArrow)
    public static let rightArrow = UInt16(kVK_RightArrow)
    public static let upArrow = UInt16(kVK_UpArrow)
}