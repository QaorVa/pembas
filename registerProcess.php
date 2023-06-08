<?php
$name = $_POST['name'];
$age = $_POST['age'];
$address = $_POST['address'];
$phone_no = $_POST['phone_no'];
$email = $_POST['email'];
$password = $_POST['password'];
include "connection.php";
$sql = "call createReader('$name', '$email', '$password', '$age', '$address', '$phone_no')";
$query = $db->query($sql);

header("location:login.php");
