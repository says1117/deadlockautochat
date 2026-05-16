#Requires AutoHotkey v2.0

; ── CONFIGURATION ──────────────────────────────────────────────────────────────
; Pixel coordinate to watch in the kill feed (screen coordinates)
PIXEL_X := 343
PIXEL_Y := 286

; specified infernus kill feed icon color (red-orange) and how much it can vary
TARGET_COLOR    := 0xE54E3A
#variety amount. i dont want it to vary because its a hard-coded hex number that doesnt deal with background fluctuation
COLOR_TOLERANCE := 0

; How often to check the pixel (milliseconds)
POLL_INTERVAL := 500

; Minimum time between taunts (milliseconds)
TAUNT_COOLDOWN := 5000
; ───────────────────────────────────────────────────────────────────────────────

; ── TAUNT MESSAGES ─────────────────────────────────────────────────────────────
; aura voicelines. heh.
taunts := [
    "erm chat looks like you burned",
    "another one bites the dust",
    "get rekt, heh. slowpoke.",
    "first, i soak em",
    "i'll light em up!:)",
    "that looked painful...",
    "should've dodged noob",
    "not even close",
    "hohohohoh, they are gonna burn",
    "None of you are on my level.",
    "You gotta try a lot harder than that!"
]
; ───────────────────────────────────────────────────────────────────────────────

; ── STATE ──────────────────────────────────────────────────────────────────────
global scriptEnabled := true
global lastTauntTime := 0
global lastPixelMatch := false
; ───────────────────────────────────────────────────────────────────────────────

; Use absolute screen coordinates for pixel reading
CoordMode("Pixel", "Screen")

; ── TOGGLE HOTKEY (F10) ────────────────────────────────────────────────────────
F10:: {
    #This is literally used to only pause. PRESS F10 TO PAUSE, F10 AGAIN TO UNPAUSE!!
    global scriptEnabled
    scriptEnabled := !scriptEnabled
    TrayTip("Infernus Taunt", scriptEnabled ? "Enabled" : "Disabled", 1)
}
; ───────────────────────────────────────────────────────────────────────────────

; ── MAIN POLL LOOP ─────────────────────────────────────────────────────────────
SetTimer(PollKillFeed, POLL_INTERVAL)

PollKillFeed() {
    global scriptEnabled, lastTauntTime, taunts, lastPixelMatch
    global PIXEL_X, PIXEL_Y, TARGET_COLOR, COLOR_TOLERANCE, TAUNT_COOLDOWN

    if !scriptEnabled
        return

    #gets the color of the x,y values that are hard-coded by me for specific region color
    color := PixelGetColor(PIXEL_X, PIXEL_Y)
    #ensures the match
    currentMatch := ColorMatches(color, TARGET_COLOR, COLOR_TOLERANCE)

    ; Only fire on the rising edge (icon just appeared)
    #makes sure its a match and not the most recent pixel, so it knows theres actually been a kill
    if (currentMatch && !lastPixelMatch) {
        
        #calculates the time to see if its greater than cooldown, if so, send the taunt and update the lastTauntTime to be the current A_TickCount
        #keeps global TickCount to check for this. background running
        if (A_TickCount - lastTauntTime >= TAUNT_COOLDOWN) {
            lastTauntTime := A_TickCount
            SendTaunt(taunts[Random(1, taunts.Length)])
        }
    }

    lastPixelMatch := currentMatch
}
; ───────────────────────────────────────────────────────────────────────────────

; ── COLOR MATCH WITH TOLERANCE ─────────────────────────────────────────────────
; returns true if each RGB channel of 'color' is within 'tolerance' of 'target'
ColorMatches(color, target, tolerance) {
    #bit offsets used for red, green, blue. masked with 0xFF

    #16 bit shift to the right
    r1 := (color  >> 16) & 0xFF
    g1 := (color  >>  8) & 0xFF
    #8 bit shift to the right
    b1 :=  color         & 0xFF

    r2 := (target >> 16) & 0xFF
    g2 := (target >>  8) & 0xFF
    b2 :=  target        & 0xFF

    #checks if the absolute value of each color value is within the tolerance (i have the tolerance set to 0)
    return (Abs(r1 - r2) <= tolerance)
        && (Abs(g1 - g2) <= tolerance)
        && (Abs(b1 - b2) <= tolerance)
}
; ───────────────────────────────────────────────────────────────────────────────

; ── SEND TAUNT TO GAME CHAT ────────────────────────────────────────────────────
; Opens chat with Enter, types the message, closes with Enter
SendTaunt(msg) {
    #this is the fastest ive used that actually flows with the gameplay and doesnt hiccup!


    Send("{Enter}")
    Sleep(26)
    SendText(msg)
    Sleep(26)
    Send("{Enter}")
}
; ───────────────────────────────────────────────────────────────────────────────
