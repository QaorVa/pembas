<?php
    include "connection.php";
    session_start();
    $loanId = $_GET['id'];
    $readerId = $_SESSION['reader_id'];
    $sql = "call returnBook('$loanId', '$readerId')";
    $query = $db->query($sql);
    header("location:viewLoanHistoryProcess.php");
?>