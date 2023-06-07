<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>Document</title>
</head>
<body>
    <!-- <form action="viewProfile.php" method="post">
        Enter Reader ID
        <input type="number" name="readerId">
        <input type="submit" value="View Profile">
    </form>
    <hr>
    <form action="viewBooks.php" method="post">
        <input type="submit" name="checkBooks" value="Check Books Available">
    </form>
    <hr>
    <form action="loanBook.php" method="post">
        Enter Reader ID<input type="number" name="readerId"><br>
        Enter ISBN<input type="number" name="isbn"><br>
        Enter Loan ID<input type="number" name="loanId">
        <input type="submit" value="Loan a book">
    </form>
    <hr> -->
    <table class="table table-striped">
        </thead>
        <tbody>
            <tr>
                <th class="w-25"><h3>Enter Reader ID</h3></th>
                <form action="viewProfile.php" method="post">
                <td class="w-25">
                        <input type="number" name="readerId" class="form-control">
                </td>
                <td class="w-50">
                        <input type="submit" value="View Profile" class="btn btn-primary">
                </td>
                </form>
            </tr>
            <tr>
                <th>
                    <form action="viewBooks.php" method="post">
                        <input type="submit" name="checkBooks" value="Check Books Available" class="btn btn-primary">
                    </form>
                </th>
            </tr>
            <form action="loanBook.php" method="post">
                <tr>
                    <th class="w-25"><h3>Enter Reader ID</h3></th>
                    <td class="w-25">
                            <input type="number" name="readerId" class="form-control">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th class="w-25"><h3>Enter ISBN</h3></th>
                    <td class="w-25">
                            <input type="number" name="isbn" class="form-control">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th class="w-25"><h3>Enter Loan ID</h3></th>
                    <td class="w-25">
                            <input type="number" name="loanId" class="form-control">
                    </td>
                    <td class="w-50">
                            <input type="submit" value="Loan a book" class="btn btn-primary">
                    </td>
                </tr>
            </form>    
        </tbody>
    </table>
    <script src="js/bootstrap.js"></script>
</body>
</html>