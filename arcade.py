import os
import sys

from PyQt6.QtCore import QUrl
from PyQt6.QtGui import QIcon
from PyQt6.QtWidgets import QApplication
from PyQt6.QtQml import QQmlApplicationEngine


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setDesktopFileName("Classic Arcade Games")
    app.setWindowIcon(QIcon(os.path.join(CURRENT_DIR, "joystick.png")))
    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile(os.path.join(CURRENT_DIR, "Main.qml")))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
