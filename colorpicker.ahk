#Requires AutoHotkey v2.0

CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")

SetTimer(ShowInfo, 100)

ShowInfo() {
    MouseGetPos(&mx, &my)
    color := PixelGetColor(mx, my)
    ToolTip(Format("X: {}  Y: {}  Color: 0x{:06X}", mx, my, color))
}

; ts is auto running, will appear as tooltip on screen to find color + coordinates of what u wanna use (make it a distinct color for the character not black or smth)
; reason why not hard coded position is because the coordinates i use for one char might not be what u wanna use for another char

; Press Escape to exit
Escape:: ExitApp
