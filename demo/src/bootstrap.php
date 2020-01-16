<?php

require_once('BankAccount.php');
require_once('BankAccountException.php');

$ba = new BankAccount();
$ba->depositMoney(100);
echo $ba->getBalance();
