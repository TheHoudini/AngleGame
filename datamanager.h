#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QSettings>

class DataManager : public QObject
{
    Q_OBJECT

    bool m_pcAvailable;

    bool m_mpAvailable;

    QString m_pcPlayerName;

    QString m_mpFirstPlayerName;

    QString m_mpSecondPlayerName;

    QVariantList m_pcField;

    QVariantList m_mpField;



    int m_pcTime;

    int m_pcStep;

    int m_mpTime;

    int m_mpStep;

    bool m_pcIsFpSide;

    bool m_pcIsFPActive;

    int m_pcCurrentPlayer;

    int m_mpCurrentPlayer;

    int m_maxStepCount;

public:
    explicit DataManager(QObject *parent = 0);
    ~DataManager();

    Q_PROPERTY(bool pcAvailable READ pcAvailable WRITE setPcAvailable NOTIFY pcAvailableChanged)
    Q_PROPERTY(QString pcPlayerName READ pcPlayerName WRITE setpcPlayerName NOTIFY pcPlayerNameChanged)
    Q_PROPERTY(QVariantList pcField READ pcField WRITE setPcField NOTIFY pcFieldChanged)
    Q_PROPERTY(int pcTime READ pcTime WRITE setPcTime NOTIFY pcTimeChanged)
    Q_PROPERTY(int pcStep READ pcStep WRITE setPcStep NOTIFY pcStepChanged)
    Q_PROPERTY(bool pcIsFpSide READ pcIsFpSide WRITE setPcIsFpSide NOTIFY pcIsFpSideChanged)
    Q_PROPERTY(int pcCurrentPlayer READ pcCurrentPlayer WRITE setPcCurrentPlayer NOTIFY pcCurrentPlayerChanged)


    Q_PROPERTY(bool mpAvailable READ mpAvailable WRITE setMpAvailable NOTIFY mpAvailableChanged)
    Q_PROPERTY(QString mpFirstPlayerName READ mpFirstPlayerName WRITE setMpFirstPlayerName NOTIFY mpFirstPlayerNameChanged)
    Q_PROPERTY(QString mpSecondPlayerName READ mpSecondPlayerName WRITE setMpSecondPlayerName NOTIFY mpSecondPlayerNameChanged)
    Q_PROPERTY(QVariantList mpField READ mpField WRITE setMpField NOTIFY mpFieldChanged)
    Q_PROPERTY(int mpTime READ mpTime WRITE setMpTime NOTIFY mpTimeChanged)
    Q_PROPERTY(int mpStep READ mpStep WRITE setMpStep NOTIFY mpStepChanged)
    Q_PROPERTY(int mpCurrentPlayer READ mpCurrentPlayer WRITE setMpCurrentPlayer NOTIFY mpCurrentPlayerChanged)

    Q_PROPERTY(int maxStepCount READ maxStepCount WRITE setMaxStepCount NOTIFY maxStepCountChanged)

    bool pcAvailable() const;

    bool mpAvailable() const;

    QString pcPlayerName() const;

    QString mpFirstPlayerName() const;

    QString mpSecondPlayerName() const;

    QVariantList pcField() const;

    QVariantList mpField() const;

    int pcTime() const;

    int pcStep() const;

    bool pcIsFpSide() const;

    int pcCurrentPlayer() const;

    int mpCurrentPlayer() const;

    int mpTime() const;

    int mpStep() const;

    int maxStepCount() const;

signals:

    void pcAvailableChanged(bool pcAvailable);

    void mpAvailableChanged(bool mpAvailable);

    void pcPlayerNameChanged(QString pcPlayerName);

    void mpFirstPlayerNameChanged(QString mpFirstPlayerName);

    void mpSecondPlayerNameChanged(QString mpSecondPlayerName);

    void pcFieldChanged(QVariantList pcField);

    void mpFieldChanged(QVariant mpField);

    void pcTimeChanged(int pcTime);

    void pcStepChanged(int pcStep);

    void pcIsFpSideChanged(bool pcIsFpSide);


    void pcCurrentPlayerChanged(int pcCurrentPlayer);

    void mpCurrentPlayerChanged(int mpCurrentPlayer);

    void mpTimeChanged(int mpTime);

    void mpStepChanged(int mpStep);

    void maxStepCountChanged(int maxStepCount);

public slots:
    void loadSettings();
    void saveSettings();

    void setPcAvailable(bool pcAvailable);
    void setMpAvailable(bool mpAvailable);
    void setpcPlayerName(QString pcPlayerName);
    void setMpFirstPlayerName(QString mpFirstPlayerName);
    void setMpSecondPlayerName(QString mpSecondPlayerName);
    void setPcField(QVariantList pcField);
    void setMpField(QVariantList mpField);
    void setPcTime(int pcTime);
    void setPcStep(int pcStep);
    void setPcIsFpSide(bool pcIsFpSide);
    void setPcCurrentPlayer(int pcCurrentPlayer);
    void setMpCurrentPlayer(int mpCurrentPlayer);
    void setMpTime(int mpTime);
    void setMpStep(int mpStep);
    void setMaxStepCount(int maxStepCount);
};

#endif // DATAMANAGER_H
