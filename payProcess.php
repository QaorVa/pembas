<?php
    include "connection.php";
    session_start();
    $fineId = $_GET['id'];
    $readerId = $_SESSION['reader_id'];
    $sql = "call payFine('$readerId', '$fineId')";
    $query = $db->query($sql);
    header("location:viewFineHistory.php");
?>