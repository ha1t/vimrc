#!/usr/bin/env php
<?php
/**
 *
 *
 */

function usage()
{

print <<<EOT
Usage:
    $0 [-c] [-f <errorfile>] <programfile> [programargs]

    -c  compile only, don't run (executes 'perl -wc')
    -f  write errors to <errorfile>

    Examples:
    * At the command line:
    $0 program.pl
    Displays output on STDOUT.

    $0 -c -f errorfile program.pl
    Then run 'vim -q errorfile' to edit the errors with Vim.

    * In Vim:
    Edit in Vim (and save, if you don't have autowrite on), then
    type ':mak' or ':mak args' (args being the program arguments)
    to error check.
EOT;
    exit();
};

if (count($argv) < 2) {
    usage();
}

array_shift($argv);
$filename = array_shift($argv);

$re = exec("php -l {$filename} 2>&1", $output);

if (strpos($re, 'No syntax errors') === false) {
    foreach ($output as $part) {
        $result = preg_match('/^.*?:(.*?) in (.*?) on line (\d+)/', $part, $matches);
        if ($result) {
            $matches = array_map('trim', $matches);
            $message = $matches[1];
            $file = $matches[2];
            $lineno = $matches[3];
            $rest = '';

            echo "{$file}:{$lineno}:{$message}" . PHP_EOL;
        }
    }
}
?>
