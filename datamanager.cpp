#include "datamanager.h"
#include <QDebug>

#define PC_AVAILABLE "pcAvailable"
#define MP_AVAILABLE "mpAvailable"
#define PC_PLAYER_NAME "pcPlayerName"
#define PC_TIME "pcTime"
#define PC_STEP "pcStep"
#define PC_IS_FP_SIDE "pcIsFpSide"
#define PC_ACTIVE_PLAYER "pcActivePlayer"

#define MP_FIRST_PLAYER "mpFirstPlayer"
#define MP_SECOND_PLAYER "mpSecondPlayer"
#define PC_FIELD "pcField"
#define MP_FIELD "mpField"
#define MP_TIME "mpTime"
#define MP_STEP "mpStep"
#define MP_ACTIVE_PLAYER "mpActivePlayer"


#define GAME_MAX_STEPS "gameMaxSteps"

DataManager::DataManager(QObject *parent) : QObject(parent)
{

    loadSettings();
}

DataManager::~DataManager()
{
    saveSettings();
}


void DataManager::loadSettings()
{

    QSettings settings("GameData.ini",QSettings::IniFormat);
    m_pcAvailable = settings.value(PC_AVAILABLE,false).toBool();
    m_mpAvailable = settings.value(MP_AVAILABLE,false).toBool();
    m_pcPlayerName = settings.value(PC_PLAYER_NAME,"anon").toString();
    m_mpFirstPlayerName = settings.value(MP_FIRST_PLAYER,"anon").toString();
    m_mpSecondPlayerName = settings.value(MP_SECOND_PLAYER,"anon").toString();
    m_pcField = settings.value(PC_FIELD,QVariant()).toList();
    m_mpField = settings.value(MP_FIELD,QVariant()).toList();

    m_pcTime = settings.value(PC_TIME).toInt();
    m_pcStep = settings.value(PC_STEP).toInt();
    m_pcIsFpSide = settings.value(PC_IS_FP_SIDE).toBool();

    m_mpTime = settings.value(MP_TIME).toInt();
    m_mpStep = settings.value(MP_STEP).toInt();
    m_mpCurrentPlayer = settings.value(MP_ACTIVE_PLAYER).toInt();
    m_pcCurrentPlayer = settings.value(PC_ACTIVE_PLAYER).toInt();
    m_maxStepCount = settings.value(GAME_MAX_STEPS,40).toInt();
}

void DataManager::saveSettings()
{
    QSettings settings("GameData.ini",QSettings::IniFormat);
    settings.setValue(PC_AVAILABLE,m_pcAvailable);
    settings.setValue(MP_AVAILABLE,m_mpAvailable);
    settings.setValue(PC_PLAYER_NAME,m_pcPlayerName);
    settings.setValue(PC_TIME,m_pcTime);
    settings.setValue(PC_STEP,m_pcStep);
    settings.setValue(PC_IS_FP_SIDE,m_pcIsFpSide);
    settings.setValue(PC_ACTIVE_PLAYER,m_pcCurrentPlayer);

    settings.setValue(MP_FIRST_PLAYER,m_mpFirstPlayerName);
    settings.setValue(MP_SECOND_PLAYER,m_mpSecondPlayerName);
    settings.setValue(PC_FIELD,QVariant(m_pcField));
    settings.setValue(MP_FIELD,m_mpField);
    settings.setValue(MP_TIME,m_mpTime);
    settings.setValue(MP_STEP,m_mpStep);
    settings.setValue(MP_ACTIVE_PLAYER,m_mpCurrentPlayer);
    settings.setValue(GAME_MAX_STEPS,m_maxStepCount);

}


bool DataManager::pcAvailable() const
{
    return m_pcAvailable;
}

bool DataManager::mpAvailable() const
{
    return m_mpAvailable;
}

QString DataManager::pcPlayerName() const
{
    return m_pcPlayerName;
}

QString DataManager::mpFirstPlayerName() const
{
    return m_mpFirstPlayerName;
}

QString DataManager::mpSecondPlayerName() const
{
    return m_mpSecondPlayerName;
}

QVariantList DataManager::pcField() const
{
    return m_pcField;
}

QVariantList DataManager::mpField() const
{
    return m_mpField;
}

int DataManager::pcTime() const
{
    return m_pcTime;
}

int DataManager::pcStep() const
{
    return m_pcStep;
}

bool DataManager::pcIsFpSide() const
{
    return m_pcIsFpSide;
}

int DataManager::pcCurrentPlayer() const
{
    return m_pcCurrentPlayer;
}

int DataManager::mpCurrentPlayer() const
{
    return m_mpCurrentPlayer;
}

int DataManager::mpTime() const
{
    return m_mpTime;
}

int DataManager::mpStep() const
{
    return m_mpStep;
}

int DataManager::maxStepCount() const
{
    return m_maxStepCount;
}




void DataManager::setPcAvailable(bool pcAvailable)
{
    if (m_pcAvailable == pcAvailable)
        return;

    m_pcAvailable = pcAvailable;
    emit pcAvailableChanged(pcAvailable);
}

void DataManager::setMpAvailable(bool mpAvailable)
{
    if (m_mpAvailable == mpAvailable)
        return;

    m_mpAvailable = mpAvailable;
    emit mpAvailableChanged(mpAvailable);
}

void DataManager::setpcPlayerName(QString pcPlayerName)
{
    if (m_pcPlayerName == pcPlayerName)
        return;

    m_pcPlayerName = pcPlayerName;
    emit pcPlayerNameChanged(pcPlayerName);
}

void DataManager::setMpFirstPlayerName(QString mpFirstPlayerName)
{
    if (m_mpFirstPlayerName == mpFirstPlayerName)
        return;

    m_mpFirstPlayerName = mpFirstPlayerName;
    emit mpFirstPlayerNameChanged(mpFirstPlayerName);
}

void DataManager::setMpSecondPlayerName(QString mpSecondPlayerName)
{
    if (m_mpSecondPlayerName == mpSecondPlayerName)
        return;

    m_mpSecondPlayerName = mpSecondPlayerName;
    emit mpSecondPlayerNameChanged(mpSecondPlayerName);
}

void DataManager::setPcField(QVariantList pcField)
{
    if (m_pcField == pcField)
        return;

    m_pcField = pcField;
    emit pcFieldChanged(pcField);
}

void DataManager::setMpField(QVariantList mpField)
{
    if (m_mpField == mpField)
        return;

    m_mpField = mpField;
    emit mpFieldChanged(mpField);
}

void DataManager::setPcTime(int pcTime)
{
    if (m_pcTime == pcTime)
        return;

    m_pcTime = pcTime;
    emit pcTimeChanged(pcTime);
}

void DataManager::setPcStep(int pcStep)
{
    if (m_pcStep == pcStep)
        return;

    m_pcStep = pcStep;
    emit pcStepChanged(pcStep);
}

void DataManager::setPcIsFpSide(bool pcIsFpSide)
{
    if (m_pcIsFpSide == pcIsFpSide)
        return;

    m_pcIsFpSide = pcIsFpSide;
    emit pcIsFpSideChanged(pcIsFpSide);
}

void DataManager::setPcCurrentPlayer(int pcCurrentPlayer)
{
    if (m_pcCurrentPlayer == pcCurrentPlayer)
        return;

    m_pcCurrentPlayer = pcCurrentPlayer;
    emit pcCurrentPlayerChanged(pcCurrentPlayer);
}

void DataManager::setMpCurrentPlayer(int mpCurrentPlayer)
{
    if (m_mpCurrentPlayer == mpCurrentPlayer)
        return;

    m_mpCurrentPlayer = mpCurrentPlayer;
    emit mpCurrentPlayerChanged(mpCurrentPlayer);
}

void DataManager::setMpTime(int mpTime)
{
    if (m_mpTime == mpTime)
        return;

    m_mpTime = mpTime;
    emit mpTimeChanged(mpTime);
}

void DataManager::setMpStep(int mpStep)
{
    if (m_mpStep == mpStep)
        return;

    m_mpStep = mpStep;
    emit mpStepChanged(mpStep);
}

void DataManager::setMaxStepCount(int maxStepCount)
{
    qDebug() << "save : " << maxStepCount;
    if (m_maxStepCount == maxStepCount)
        return;

    m_maxStepCount = maxStepCount;
    emit maxStepCountChanged(maxStepCount);
}



