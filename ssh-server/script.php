<?php
/**
 * @author: James Dryden <james@jdrydn.com>
 * @license: MIT
 * @link: http://jdrydn.com
 */
namespace SSH_Server;

/** @noinspection SpellCheckingInspection */
define("FAIL", " \033[0;31;49m[==]\033[0m");
/** @noinspection SpellCheckingInspection */
define("GOOD", " \033[0;32;49m[==]\033[0m");
/** @noinspection SpellCheckingInspection */
define("WARN", " \033[0;33;49m[==]\033[0m");
/** @noinspection SpellCheckingInspection */
define("TASK", " \033[0;34;49m[==]\033[0m");
/** @noinspection SpellCheckingInspection */
define("USER", " \033[1;1;49m[==]\033[0m");

function stdout()
{
	fwrite(STDOUT, implode(" ", array_map(function ($v) { return print_r($v, true); }, func_get_args())) . PHP_EOL);
}

function stderr()
{
	fwrite(STDERR, implode(" ", array_map(function ($v) { return print_r($v, true); }, func_get_args())) . PHP_EOL);
}

try
{
	if (empty($argv[1]))
	{
		stderr(FAIL, "No PWD detected.");
		exit(0);
	}

	/** @noinspection SpellCheckingInspection */
	define("PWD", $argv[1]);
	define("SSH_SERVER_INI", PWD . "/ssh-servers.ini");

	if (!file_exists(SSH_SERVER_INI))
	{
		stderr(FAIL, "No ssh-servers.ini file at", PWD . ". Bye.");
		exit(0);
	}

	if (empty($argv[2]))
	{
		stdout(GOOD, "ssh-servers.ini located at", PWD);
	}

	$servers = parse_ini_file(SSH_SERVER_INI, true);
	$newServers = array(null);
	foreach($servers as $name => $details)
	{
		$server = array_merge(
			array(
				"name" => $name,
				"host" => null,
				"user" => null,
				"pass" => null,
				"key" => null
			),
			$details
		);

		if (empty($server["host"]))
		{
			throw new \Exception("No host for '{$name}'.");
		}
		elseif (empty($server["user"]))
		{
			throw new \Exception("No user for '{$name}'.");
		}
		elseif (empty($server["key"]) && empty($server["pass"]))
		{
			throw new \Exception("No password / key for '{$name}'.");
		}

		if (!empty($server["key"]) && (substr($server["key"], 0, 1) !== "/") && (substr($server["key"], 0, 1) !== "~"))
		{
			$server["key"] = PWD . "/" . $server["key"];
		}

		$newServers[] = $server;
	}
	$servers = $newServers;
	unset($newServers, $server, $name, $details);

	// stdout(GOOD, PWD, $servers);

	if (empty($argv[2]))
	{
		if (count($servers) === 2)
		{
			$server = $servers[1];
			stdout(
				GOOD, "Connecting to", $server["user"] . "@" . $server["host"], "with",
				(!empty($server["key"]) ? "key located at " . $server["key"] : "password '" . $server["pass"] . "'")
			);
			exit(1);
		}

		stdout(PHP_EOL . "  Where would you like to go?");

		for($i = 1; $i < count($servers); $i++)
		{
			$padding = ((count($servers) > 10) && ($i < 10) ? " " : "");
			$server = $servers[$i];

			stdout(
				" \033[1;1;49m[{$i}]\033[0m{$padding}",
				$server["name"] . " (" . $server["user"] . "@" . $server["host"],
				"with a " . (!empty($server["key"]) ? "key" : "password") . ")"
			);
		}

		fwrite(STDOUT, PHP_EOL . "Please choose [1.." . (count($servers) - 1) . "]: ");
		$selection = intval(trim(fgets(STDIN)));

		if (empty($selection))
		{
			stderr(FAIL, "No server selected. Bye.");
			exit(0);
		}
		elseif (($selection <= 0) || ($selection > (count($servers) - 1)))
		{
			stderr(FAIL, "Invalid number entered. Bye.");
			exit(0);
		}

		$server = $servers[$selection];
		stdout(
			GOOD, "Connecting to", $server["user"] . "@" . $server["host"], "with",
			(!empty($server["key"]) ? "key located at " . $server["key"] : "password '" . $server["pass"] . "'")
		);
		exit($selection);
	}
	else
	{
		if (empty($servers[$argv[2]]))
		{
			stderr(FAIL, "Unknown server to connect to.");
			exit(1);
		}

		$server = $servers[$argv[2]];
		stdout(
			"ssh", $server["user"] . "@" . $server["host"] . (!empty($server["key"]) ? " -i '" . $server["key"] . "'" : "")
		);
	}
}
catch (ConfigException $e)
{
	stderr(FAIL, "Invalid ssh-servers.ini:", $e->getMessage());
}
catch (\Exception $e)
{
	stderr(FAIL, (string)$e);
}
exit(0);
