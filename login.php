#!/usr/bin/env php
<?php
/*
Copyright 2016 Daniil Gentili
(https://daniil.it)
This file is part of MadelineProto.
MadelineProto is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
MadelineProto is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.
You should have received a copy of the GNU General Public License along with MadelineProto.
If not, see <http://www.gnu.org/licenses/>.
*/

require_once 'api/vendor/autoload.php';
require_once 'storage_url.php';
$sessiondir = __DIR__.'/sessions';
$settings = ['logger' => ['logger' => 1], 'pwr' => ['pwr' => true, 'db_token' => $db_token, 'strict' => true]];

echo 'Enter the phone number you want to use for the pwrtelegram API: ';
$number = readline();
$MadelineProto = new \danog\MadelineProto\API($settings);
$sentCode = $MadelineProto->phone_login($number);
echo 'Enter the code you received: ';
$code = readline();
$authorization = $MadelineProto->complete_phone_login($code);
        if ($authorization['_'] === 'account.password') {
            \danog\MadelineProto\Logger::log(['2FA is enabled'], \danog\MadelineProto\Logger::NOTICE);
            $authorization = $MadelineProto->complete_2fa_login(readline('Please enter your password (hint '.$authorization['hint'].'): '));
        }
\danog\MadelineProto\Logger::log($authorization);
echo 'Serializing MadelineProto to '.$sessiondir.'/pwr.madeline...'.PHP_EOL;
echo 'Wrote '.\danog\MadelineProto\Serialization::serialize($sessiondir.'/pwr.madeline', $MadelineProto).' bytes'.PHP_EOL;

$settings ['connection_settings'] = [ // connection settings
        'all' => [ // Connection settings will be applied on datacenter ids matching the key of these settings subarrays, if the key is equal to all like in this case that will match all datacenters that haven't a custom settings subarray...
            'test_mode' => true, // decides whether to connect to the main telegram servers or to the testing servers (deep telegram)
            'protocol'     => 'tcp_full', // can be tcp_full, tcp_abridged, tcp_intermediate, http (unsupported), https (unsupported), udp (unsupported)
            'ipv6'         => false, // decides whether to use ipv6, ipv6 attribute of API attribute of API class contains autodetected boolean
            'timeout'      => 5, // timeout for sockets
        ],
    ];


echo 'Enter the phone number you want to use for the deep pwrtelegram API: ';
$number = readline();
$MadelineProto = new \danog\MadelineProto\API($settings);
$sentCode = $MadelineProto->phone_login($number, 0);
\danog\MadelineProto\Logger::log($sentCode);
echo 'Enter the code you received: ';
$code = readline();
$authorization = $MadelineProto->complete_phone_login($code);
        if ($authorization['_'] === 'account.password') {
            \danog\MadelineProto\Logger::log(['2FA is enabled'], \danog\MadelineProto\Logger::NOTICE);
            $authorization = $MadelineProto->complete_2fa_login(readline('Please enter your password (hint '.$authorization['hint'].'): '));
        }
\danog\MadelineProto\Logger::log($authorization);
echo 'Serializing MadelineProto to '.$sessiondir.'/deeppwr.madeline...'.PHP_EOL;
echo 'Wrote '.\danog\MadelineProto\Serialization::serialize($sessiondir.'/deeppwr.madeline', $MadelineProto).' bytes'.PHP_EOL;
