<?php
$name = $_POST['name'];
$age = $_POST['age'];
$address = $_POST['address'];
$phone_no = $_POST['phone_no'];
session_start();
$readerId = $_SESSION['reader_id'];
include "connection.php";
$sql = "call editProfile('$name', '$age', '$address', '$phone_no', '$readerId')";
$query = $db->query($sql);
header("location:profile.php?alert=berhasil");
