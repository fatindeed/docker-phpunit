<?php

class BankAccount
{
    private $balance = 0;

    public function getBalance(): int
    {
        return $this->balance;
    }

    public function depositMoney(int $amount): void
    {
        if ($amount > 0) {
            $this->balance += $amount;
        } else {
            throw new BankAccountException;
        }
    }

    public function withdrawMoney(int $amount): void
    {
        if ($amount > 0 && $this->balance >= $amount) {
            $this->balance -= $amount;
        } else {
            throw new BankAccountException;
        }
    }
}
