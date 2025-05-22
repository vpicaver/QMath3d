#include <QTest>

#include <QBox3D>
#include <QRay3D>
#include <QtMath>

namespace {
auto volume(const QBox3D box) -> qreal
{
    const auto& sz = box.size();
    return qAbs(sz.x() * sz.y() * sz.z());
}
} // namespace

class QtMath3dSuite : public QObject
{
    Q_OBJECT

private slots:
    auto qtRay3dTest() -> void;
    auto qtBox3dTest() -> void;
};

auto QtMath3dSuite::qtRay3dTest() -> void
{
    const QRay3D ray1{QVector3D{-10., -10., -10.}, QVector3D{10., 10., 10.}};
    QVERIFY(ray1.contains(QVector3D(0., 0., 0)));
    QCOMPARE(ray1.distance(QVector3D(0., 0., 0)), 0.);     // on the ray
    QCOMPARE(ray1.distance(QVector3D(10., 10., 10.)), 0.); // on the ray
    //QCOMPARE(ray1.distance(QVector3D(4., 0., 4.)), qSqrt(4 * 4 + 4 * 4));

    auto trM = QMatrix4x4{};
    trM.translate(QVector3D(40, 30, -10));
    trM.rotate(QQuaternion::fromEulerAngles(90, 90, 90));

    const auto trRay = ray1.transformed(trM);
    QVERIFY(!trRay.contains(QVector3D(0., 0., 0)));
    QCOMPARE(trRay.distance(QVector3D(0., 0., 0)), 50.990196228);
}

auto QtMath3dSuite::qtBox3dTest() -> void
{
    const QBox3D bbox{QVector3D{-10., -10., -10.}, QVector3D{10., 10., 10.}};
    QCOMPARE(bbox.size(), (QVector3D{20, 20, 20}));
    QCOMPARE(bbox.center(), QVector3D(0, 0, 0));
    QCOMPARE(volume(bbox), 8000);
    const QVector3D center{0, 0, 0};
    QCOMPARE(bbox.center(), center);

    auto trM = QMatrix4x4{};
    trM.translate(QVector3D(40, 30, -10));
    trM.rotate(QQuaternion::fromEulerAngles(90, 90, 90));

    const auto trBox = bbox.transformed(trM);
    QCOMPARE(trBox.size(), QVector3D(20, 20, 20));
    QCOMPARE(trBox.center(), QVector3D(40, 30, -10));
}

QTEST_MAIN(QtMath3dSuite)
#include "Math3d_tests.moc"
