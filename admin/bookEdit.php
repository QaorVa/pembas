<?php include 'header.php'; ?>
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
    <!--/. container-fluid -->
    <div class="container">



        <div class="card">
            <div class="card-header">
                <h6 class="m-0">Update Data Buku</h6>
            </div>
            <div class="card-body">

                <?php
                $id = $_GET['id'];
                $sql = "call readBook('$id')";
                $query = $db->query($sql);
                while ($i = mysqli_fetch_array($query)) {
                ?>

                    <form action="editBookProcess.php" method="post">
                        <div class="form-group">
                            <label for="">ISBN</label>
                            <input type="number" class="form-control" required="required" name="isbn" value="<?php echo $i['isbn'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">TITLE</label>
                            <input type="text" class="form-control" required="required" name="title" value="<?php echo $i['title'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">AUTHOR</label>
                            <input type="text" class="form-control" required="required" name="author" value="<?php echo $i['author'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">CATEGORY</label>
                            <input type="text" class="form-control" required="required" name="category" value="<?php echo $i['category'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">PUBLISHER</label>
                            <input type="text" class="form-control" required="required" name="publisher" value="<?php echo $i['publisher'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">YEAR_PUBLISHED</label>
                            <input type="number" class="form-control" required="required" name="year_published" value="<?php echo $i['year_published'] ?>">
                        </div>

                        <div class="form-group">
                            <label for="">COPIES</label>
                            <input type="number" class="form-control" required="required" name="copies" value="<?php echo $i['copies'] ?>">
                        </div>

                        <div class="form-group">
                            <input type="submit" class="btn btn-primary" value="Update Data">
                        </div>
                    </form>


                <?php
                }
                ?>

                <br />

            </div>



        </div>
    </div>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->
<?php include 'footer.php'; ?>