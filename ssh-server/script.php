<?php
/**
 * @author: James Dryden <james@jdrydn.com>
 * @license: MIT
 * @link: http://jdrydn.com
 */
namespace SSH_Server;
/** @noinspection SpellCheckingInspection */
define("FAIL", " \033[0;31;49m[==]\033[0m ");
/** @noinspection SpellCheckingInspection */
define("GOOD", " \033[0;32;49m[==]\033[0m ");
/** @noinspection SpellCheckingInspection */
define("WARN", " \033[0;33;49m[==]\033[0m ");
/** @noinspection SpellCheckingInspection */
define("TASK", " \033[0;34;49m[==]\033[0m ");
/** @noinspection SpellCheckingInspection */
define("USER", " \033[1;1;49m[==]\033[0m ");

class ConfigException extends \Exception
{
}

final class Server
{
	private $host;
	private $key;
	private $name;
	private $password;
	private $user;

	/**
	 * @param string $name
	 * @param array $details
	 * @throws ConfigException
	 */
	public function __construct($name, array $details)
	{
		$this->name = $name;
		$this->host = $details["host"];
		if (empty($details["host"]))
		{
			throw new ConfigException("No host for '{$this->name}'.");
		}

		$this->user = $details["user"];
		if (empty($details["user"]))
		{
			throw new ConfigException("No user for '{$this->name}'.");
		}

		if (!empty($details["key"]))
		{
			$this->key = $details["key"];

		}
		elseif (!empty($details["pass"]))
		{
			$this->password = $details["pass"];
		}
		else
		{
			throw new ConfigException("No password / key file for '{$this->name}'.");
		}
	}

	/**
	 * @param bool $reveal
	 * @return string
	 */
	public function toDescriptiveString($reveal = false)
	{
		return $this->user . "@" . $this->host . " with a " .
		($reveal === true ? (!empty($this->key) ? "key located at {$this->key}" : "password '{$this->password}'")
			: (!empty($this->key) ? "key" : "password"));
	}

	/**
	 * @return string
	 */
	public function toSshCommand()
	{
		if ((substr($this->key, 0, 1) !== "/") && (substr($this->key, 0, 1) !== "~"))
		{
			$this->key = PWD . "/" . $this->key;
		}
		return "ssh " . $this->user . "@" . $this->host . " " . (!empty($this->key) ? "-i " . $this->key : "");
	}
}

function stdout()
{
	$args = implode(
		" ",
		array_map(
			function ($v)
			{
				return print_r($v, true);
			},
			func_get_args()
		)
	);
	fwrite(STDOUT, $args . PHP_EOL);
}

function stderr()
{
	$args = implode(
		" ",
		array_map(
			function ($v)
			{
				return print_r($v, true);
			},
			func_get_args()
		)
	);
	fwrite(STDERR, $args . PHP_EOL);
}

try
{
	if (empty($argv[1]))
	{
		stderr(FAIL, "No PWD detected.");
		exit(2);
	}

	/** @noinspection SpellCheckingInspection */
	define("PWD", $argv[1]);
	define("SSH_SERVER_INI", PWD . "/ssh-servers.ini");

	if (!file_exists(SSH_SERVER_INI))
	{
		stderr(FAIL, "No ssh-servers.ini file at", PWD);
		exit(2);
	}

	$servers = parse_ini_file(SSH_SERVER_INI, true);

	// stdout(GOOD, PWD, $servers);

	foreach ($servers as $name => &$details)
	{
		$details = new Server($name, $details);
	}

	if (empty($argv[2]))
	{
		stdout("List of servers to SSH to:");
		/**
		 * @var string $name
		 * @var Server $server
		 */
		foreach ($servers as $name => $server)
		{
			stdout(TASK, $name, "(" . $server->toDescriptiveString() . ")");
		}
		exit(1);
	}
	else
	{
		if (!array_key_exists($argv[2], $servers))
		{
			stderr(FAIL, "Unknown server to connect to.");
			exit(1);
		}

		/** @var Server $server */
		$server = $servers[$argv[2]];
		if (empty($_SERVER["RETURN_CMD"]))
		{
			stdout($server->toDescriptiveString(true));
		}
		else
		{
			stdout($server->toSshCommand());
		}
		exit(0);
	}
}
catch (ConfigException $e)
{
	stderr(FAIL, "Invalid ssh-servers.ini:", $e->getMessage());
	exit(3);
}
catch (\Exception $e)
{
	stderr(FAIL, (string)$e);
	exit(3);
}
