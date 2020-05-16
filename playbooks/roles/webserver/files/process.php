<?php

session_start();

$mysqli = new mysqli('192.168.20.41','vagrant','vagrant', 'skylab') or die(mysqli_error($mysqli));

	if (isset($_POST['save'])){
		$klant = $_POST['klant'];
		$omgeving = $_POST['omgeving'];
		$servernaam = $_POST['servernaam'];

		$mysqli->query("INSERT INTO customer (klant, omgeving, servernaam) VALUES('$klant','$omgeving',
			'$servernaam')") or
				die ($mysqli->error);

		header("location: index.php");

	}

	if (isset($_GET['delete'])){
		$id = $_GET['delete'];
		$mysqli->query("DELETE FROM customer WHERE id=$id") or die ($mysqli->error());
		

		header("location: index.php");

	
	}

?>