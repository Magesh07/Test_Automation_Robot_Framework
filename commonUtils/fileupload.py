import clipboard as c
import pyautogui
import time
import logging


def clipboard(path):
    print(path)
    logging.info(path)
    c.copy(path)
    pyautogui.keyDown('ctrl')
    with pyautogui.hold('ctrl'):
        pyautogui.press('v')
    time.sleep(2.4)
    pyautogui.press('enter')
    pyautogui.keyUp('ctrl')
    pyautogui.keyUp('v')
    pyautogui.keyUp('enter')

