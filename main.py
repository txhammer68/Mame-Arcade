import sys
import os
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QIcon
from PySide6.QtCore import QUrl

CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))
os.environ['QT_PLUGIN_PATH'] = '/usr/lib/qt6/plugins:/usr/lib/qt6/qml'
os.environ['QTWEBENGINEPROCESS_PATH']='/usr/lib/qt6/qml/QtWebEngine/:/home/matt/.local/lib/python3.13/site-packages/PyQt6/:/home/matt/.local/lib/python3.13/site-packages/PySide6/'
os.environ['QT_QPA_PLATFORM']="wayland"


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setDesktopFileName('Wizard Arcade')
    app.setWindowIcon(QIcon(os.path.join(CURRENT_DIR, "joystick.png")))
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.addImportPath("/usr/lib/qt6/qml")
    engine.load(QUrl.fromLocalFile(os.path.join(CURRENT_DIR, "Main.qml")))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
