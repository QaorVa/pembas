<?php
include "connection.php";
session_start();
if (!isset($_SESSION['reader_id'])) {
  header("location: login.php");
  exit;
}
$readerId = $_SESSION['reader_id'];
$sqlName = "select name from reader where reader_Id = $readerId";
$result = $db->query($sqlName);
if ($result->num_rows == 1) {
  $row = $result->fetch_assoc();
  $name = $row["name"];
}

$sqlBooks = "CALL bookAvail()";
$queryBooks = $db->query($sqlBooks);
$books = [];
while ($row = $queryBooks->fetch_assoc()) {
  $books[] = $row;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Sistem Informasi Perpustakaan</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>

<body class="hold-transition dark-mode sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
  <div class="wrapper">

    <!-- Preloader -->
    <div class="preloader flex-column justify-content-center align-items-center">
      <img class="animation__wobble" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
    </div>

    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-dark">
      <!-- Left navbar links -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <!-- <li class="nav-item d-none d-sm-inline-block">
        <a href="index3.html" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li> -->
      </ul>

      <!-- Right navbar links -->
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a href="logout.php" role="button" class="text-light">
            <span>Logout</span>
            <i class="fas fa-power-off"></i>
          </a>
        </li>
      </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
      <a href="index.php" class="brand-link">
        <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">SI Perpustakaan</span>
      </a>

      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <!-- <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Alexander Pierce</a>
        </div>
      </div> -->

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="image">
            <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
          </div>
          <div class="info">
            <a href="profile.php" class="d-block"><?php echo $name ?></a>
          </div>
        </div>

        <!-- SidebarSearch Form -->
        <div class="form-inline">
          <div class="input-group" data-widget="sidebar-search">
            <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
              <button class="btn btn-sidebar">
                <i class="fas fa-search fa-fw"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
            <li class="nav-item menu-open">
              <a href="#" class="nav-link active">
                <i class="nav-icon fas fa-tachometer-alt"></i>
                <p>
                  Dashboard
                  <i class="right fas fa-angle-left"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="index.php" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Loan A Book</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="viewLoanHistoryProcess.php" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Borrowed Books</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="viewFineHistory.php" class="nav-link active">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Fine History</p>
                  </a>
                </li>
                <!-- <li class="nav-item">
                  <a href="./index3.html" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Dashboard v3</p>
                  </a>
                </li> -->
              </ul>
            </li>
            <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0">SISTEM INFORMASI PERPUSTAKAAN</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active">Loan A Book</li>
              </ol>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content-header -->

      <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <div class="col-md-12">
            <div class="card">
              <div class="">
                <div class="card-header">
                  <h1 class="text-center">Your Fine History</h1>
                </div>
                <div class="card-body p-0">
                  <div class="table-responsive">
                    <?php
                    echo '<table class="table m-0 text-center">',
                    "<tr>",
                    "<th >Fine Date</th>",
                    "<th class='w-25'>Amount</th>",
                    "<th class='w-25'>Paid?</th>",
                    "<th style='width: 100px'></th>",
                    "</tr>";
                    include "connection.php";
                    $sql = "call readAllFine($readerId)";
                    $query = $db->query($sql);

                    if($query->num_rows >0) {
                        foreach ($query as $row) {
                            echo "<tr>",
                            "<td>", $row['fine_date'], "</td>",
                            "<td>", $row['amount'], "</td>",
                            "<td>", $row['paid'], "</td>";
                            if($row['paid'] == "No") {
                                echo "<td><a class='text-light btn-sm btn-primary' href='payProcess.php?id=",$row['fine_id'],"'>Pay</a></td>";
                            } else if($row['paid'] == "Yes"){
                                echo "<td></td>";
                            }
                            
                            "</tr>";
                          }
                    } else {
                        echo"<tr>",
                        "<td></td>",
                        "<td>-- No Fine History Found --</td>",
                        "<td></td></tr>";
                    }
                    echo "</table>";
                    ?>
                  </div>
                </div>
              </div>
            </div> <!-- card -->
          </div>
        </div><!--/. container-fluid -->
      </section>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->

    <!-- Main Footer -->
    <footer class="main-footer">
      <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
      All rights reserved.
      <div class="float-right d-none d-sm-inline-block">
        <b>Version</b> 3.2.0
      </div>
    </footer>
  </div>
  <!-- ./wrapper -->

  <!-- REQUIRED SCRIPTS -->
  <!-- jQuery -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- overlayScrollbars -->
  <script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
  <!-- AdminLTE App -->
  <script src="dist/js/adminlte.js"></script>

  <!-- PAGE PLUGINS -->
  <!-- jQuery Mapael -->
  <script src="plugins/jquery-mousewheel/jquery.mousewheel.js"></script>
  <script src="plugins/raphael/raphael.min.js"></script>
  <script src="plugins/jquery-mapael/jquery.mapael.min.js"></script>
  <script src="plugins/jquery-mapael/maps/usa_states.min.js"></script>
  <!-- ChartJS -->
  <script src="plugins/chart.js/Chart.min.js"></script>

  <!-- AdminLTE for demo purposes -->
  <!-- <script src="dist/js/demo.js"></script> -->
  <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
  <script src="dist/js/pages/dashboard2.js"></script>
</body>

</html>