<?php

$mysqli = new mysqli('192.168.20.41','vagrant','vagrant', 'skylab') or die(mysqli_error($mysqli));

	if (isset($_POST['save'])){
		$klant = $_POST['klant'];
		$omgeving = $_POST['omgeving'];
		$servernaam = $_POST['servernaam'];

		$mysqli->query("INSERT INTO customer (klant, omgeving, servernaam) VALUES('$klant','$omgeving',
			'$servernaam')") or
				die ($mysqli->error);

			$_SESSION['message'] = "Record has been saved!";
			$_SESSION['msg_type'] = "success";

			header("location: index.php");
			die();

	}

	if (isset($_GET['delete'])){
		$id = $_GET['delete'];
		$mysqli->query("DELETE FROM customer WHERE id=$id") or die ($mysqli->error());

			$_SESSION['message'] = "Record has been deleted!";
			$_SESSION['msg_type'] = "danger";
			

			header("location: index.php");
			die();
			
	}

?>