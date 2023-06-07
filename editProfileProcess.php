<?php
$name = $_POST['name'];
$age = $_POST['age'];
$address = $_POST['address'];
$phone_no = $_POST['phone_no'];
include "connection.php";
$sql = "call editProfile($name, $age, $address, $phone_no)";
$query = $db->query($sql);
