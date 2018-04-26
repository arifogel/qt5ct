#include <QApplication>
#include <QMessageBox>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    //a.setStyle("GTK+");

    // Invert the palette, for reasons
    QPalette palette = QApplication::palette();

    for (int group = 0; group < QPalette::NColorGroups; group++) {
        QPalette::ColorGroup colorGroup = QPalette::ColorGroup(group);
        for (int role = 0; role < QPalette::NColorRoles; role++) {
            QPalette::ColorRole colorRole = QPalette::ColorRole(role);
            QColor color = palette.color(colorGroup, colorRole);
            QColor inverted(255 - color.red(), 255 - color.green(), 255 - color.blue(), color.alpha());
            palette.setColor(colorGroup, colorRole, inverted);
        }
    }
    QApplication::setPalette(palette);

    QMessageBox msg;
    msg.setText("Test");
    msg.show();

    return a.exec();
}
