<?php
// menghubungkan dengan koneksi
include "connection.php";

// menangkap data yang dikirim dari form
$email = $_POST['email'];
$password = $_POST['password'];

$masuk = mysqli_query($db, "SELECT * FROM reader WHERE email = '$email' AND password = '$password'");
$cek = mysqli_num_rows($masuk);

if ($cek > 0) {
    session_start();
    $data = mysqli_fetch_assoc($masuk);

    // buat session member
    $_SESSION['reader_id'] = $data['reader_id'];
    $_SESSION['member_status'] = "login";
    header("location:index.php");
} else {
    echo '<script>alert("Invalid email or password"); window.location.href = "login.php";</script>';
}
