<!doctype html>
<html lang="en">
   <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <title>SkyLab</title>
   </head>
   <body>
      <?php require_once 'process.php'; ?>

      <?php
         if ($msgsend == true): ?>

         <div class="alert alert-<?=$_SESSION['msg_type']?>">

            <?php
               echo $_SESSION['message'];

               

            ?>
         </div>
         <?php endif ?>



      <div class="container">
      <?php
         $mysqli = new mysqli('192.168.20.41','vagrant','vagrant', 'skylab') or die(mysqli_error($mysqli));
         $result = $mysqli->query("SELECT * FROM customer") or die($mysqli->error());
      ?>

           <div class="row justify-content-center">
              <table class="table">
                 <thead>
                    <tr>
                       <th>Customer ID</th>
                       <th>Customer</th>
                       <th>Environment</th>
                       <th>Servername</th>
                       <th colspan="4">Action</th>
                    </tr>
                 </thead>
      <?php
         while ($row = $result->fetch_assoc()): ?>
            <tr>
               <td><?php echo $row['id']; ?></td>
               <td><?php echo $row['klant']; ?></td>
               <td><?php echo $row['omgeving']; ?></td>
               <td><?php echo $row['servernaam']; ?></td>
               <td>
                  <a href="index.php?edit=<?php echo $row['id']; ?>"
                     class="btn btn-info">Edit</a>
                  <a href="process.php?delete=<?php echo $row['id']; ?>"
                     class="btn btn-danger">Delete</a>

               </td>
            </tr>
         <?php endwhile; ?>

                    </table>
            </div>
         <?php
            function pre_r( $array ) {
               echo '<pre>';
               print_r($array);
               echo '<pre>';
            }
         ?>

         <div class="row justify-content-center"> 
            <form action="process.php" method="POST">
               <div class="form-group">
                  <label>Customer</label>
                  <input type="text" name="klant" class="form-control" placeholder="Voer uw naam in">
               </div>
               <div class="form-group">
                  <label>Environment</label>
                  <input type="text" name="omgeving" class="form-control" placeholder="Wilt u een productie of test omgeving">
               </div>
               <div class="form-group">
                  <label>Servername</label>
                  <input type="text" name="servernaam" class="form-control" placeholder="Voer uw servernaam in">
               </div>
               <div class="form-group">
                  <button type="submit" class="btn btn-primary" name="save">Add environment</button>
               </div>
            </form>
         </div>































         <!-- Optional JavaScript -->
         <!-- jQuery first, then Popper.js, then Bootstrap JS -->
         <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
      </div>
   </body>
</html>