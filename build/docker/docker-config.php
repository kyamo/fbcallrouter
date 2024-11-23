<?php

$config = [
    'fritzbox' => [
        'url'      => '${FRITZ_URL}',   // your Fritz!Box IP
        'user'     => '${FRITZ_USER}',  // your Fritz!Box user
        'password' => '${FRITZ_PASS}',  // your Fritz!Box user password
    ],
    'phonebook' => [
        'whitelist' => [${PHONEBOOK_WHITELIST}],    // phone books number is already known (first index = 0!)
        'blacklist' => ${PHONEBOOK_BLACKLIST},  // phone book in which the spam number should be recorded
        'newlist'   => ${PHONEBOOK_NEWLIST},    // optional: phone book in which the reverse searchable entries should be recorded
        'refresh'   => ${PHONEBOOK_REFRESH},    // after how many days the phone books should be read again
    ],
    'contact' => [
        'caller'    => '${CONTACT_CALLER}', // alias for the new unknown caller
        'timestamp' => ${CONTACT_TIMESTAMP},    // adding timestamp to the caller: "[caller] ([timestamp])"
        'type'      => '${CONTACT_TYPE}',   // type of phone line (home, work, mobil, fax etc.); 'other' = 'sonstige'
    ],
    'filter' => [
        'msn'          => [${FILTER_MSN}],  // MSNs to react on (['321765', '321766']; empty = all)
        'blockForeign' => ${FILTER_BLOCKFOREIGN},   // block unknown foreign numbers
        'score'        => ${FILTER_SCORE},  // 5 = neutral, increase the value to be less sensitive (max. 9)
        'comments'     => ${FILTER_COMMENTS},  // decrease the value to be less sensitive (min 3)
    ],
    'logging' => [
        'log'     => ${LOGGING_LOG},
        'logPath' => '${LOGGING_LOGPATH}',  // were callrouter_logging.txt schould be saved (default value is = './')
    ],
    /*
    'email' => [
        'url'      => 'smtp...',
        'port'     => 587,                                          // alternativ 465
        'secure'   => 'tls',                                        // alternativ 'ssl'
        'user'     => '[USER]',                                     // your sender email adress e.g. account
        'password' => '[PASSWORD]',
        'receiver' => 'blacksenator@github.com',                    // your email adress to receive the secured contacts
        'debug'    => 0,                                            // 0 = off (for production use)
                                                                    // 1 = client messages
                                                                    // 2 = client and server messages
    ],
    */
    'test' => [                 // if program is started with the -t option...
        'numbers' => [          // ...the numbers are injected into the following calls
            '03681443300750',   // tellows score > 5, comments > 3
            '0207565747377',    // not existing NDC/STD (OKNz)
            '0618107162530',    // valid NDC/STD, but invalid subscriber number
            '004433456778',     // foreign number
            '',                 // unknown caler (uses CLIR)
        ],
    ],
];