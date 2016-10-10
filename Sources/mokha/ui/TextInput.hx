package mokha.ui;

import mokha.managers.input.KeyboardInputManager;
import mokha.ui.Text;

import kha.Font;

/**
    Simple text input class which has its value changed through
    keyboard input.
**/
class TextInput extends Text {
    /**
        Regular expression rule for keyboard characters allowed to
        be used as input.
    **/
    public var rule : EReg;

    /**
        Creates new text input.
        @param	font	Font family
        @param	size	Font size
    **/
    public function new(font : Font, size : Int) : Void {
        super("", font, size);

        rule = ~/.{1}/i;
    }

    /**
        Handles keyboard input.
        @param	keys	Keyboard input manager
    **/
    public function handleInput(keys : KeyboardInputManager) : Void {
        if (keys.justPressedSpecialKey == "char") {
            if (keys.justPressedKey != null && rule.match(keys.justPressedKey)) {
                value += keys.justPressedKey;
            }
        }

        if (keys.justPressedSpecialKey == "backspace") {
            if (value.length > 0) {
                value = value.substr(0, value.length - 1);
            }
        }
    }
}
