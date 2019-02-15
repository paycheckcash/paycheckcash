// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef PAYCHECKCASH_QT_PAYCHECKCASHADDRESSVALIDATOR_H
#define PAYCHECKCASH_QT_PAYCHECKCASHADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class PaycheckCashAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit PaycheckCashAddressEntryValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

/** PaycheckCash address widget validator, checks for a valid paycheckcash address.
 */
class PaycheckCashAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit PaycheckCashAddressCheckValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

#endif // PAYCHECKCASH_QT_PAYCHECKCASHADDRESSVALIDATOR_H
