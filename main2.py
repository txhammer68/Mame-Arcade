import sys
import os
from PyQt6.QtCore import QUrl
from PyQt6.QtGui import QIcon
from PyQt6.QtWidgets import QApplication
from PyQt6.QtQml import QQmlApplicationEngine

CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))
pyqt6_plugins_path = os.path.join(
    sys.prefix,  # Path to your virtual environment root
    'lib',
    f'python{sys.version_info.major}.{sys.version_info.minor}',
    'site-packages', 'PyQt6', 'Qt6', 'plugins'
)
os.environ['QT_PLUGIN_PATH'] = '/usr/lib/qt6/plugins:/usr/lib/qt6/qml'
os.environ['QTWEBENGINEPROCESS_PATH']='/usr/lib/qt6/qml/QtWebEngine/:/home/matt/.local/lib/python3.13/site-packages/PyQt6/:/home/matt/.local/lib/python3.13/site-packages/PySide6/'
os.environ['QT_QPA_PLATFORM']="wayland"


if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setDesktopFileName('Wizard Arcade')
    app.setWindowIcon(QIcon(os.path.join(CURRENT_DIR, "joystick.png")))
    engine = QQmlApplicationEngine()
    engine.addImportPath("/usr/lib/qt6/qml")
    engine.load(QUrl.fromLocalFile(os.path.join(CURRENT_DIR, "Main.qml")))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
