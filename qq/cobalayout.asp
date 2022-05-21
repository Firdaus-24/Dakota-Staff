<!DOCTYPE html>
<html lang=”en”>
    <head>
        <meta charset=”UTF-8″>
        <meta name=”viewport” content=”width=device-width, initial-scale=1.0″>
        <meta http-equiv=”X-UA-Compatible” content=”ie=edge”>
    <title>Layout</title>
        <style>
        
        body {
            background-color: white;
            color: black;
        }
            div {
                margin-top: 130px;
                margin-bottom: 100px;
                margin-right: 100px;
                margin-left: 80px;
                border-style: solid;
                border-width: 1px;
            }
            
        </style>
    </head>
<body>
       <br>
       <div class="container">
  <div class="row">
  <div class="col-sm-12">
    <div class="col">col</div>
    <div class="col">col</div>
    <div class="col">col</div>
    <div class="col">col</div>
  </div>
  </div>
  <div class="row">
            <div class="col-5">
        <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-end">
          <li class="page-item disabled">
            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
          </li>
              <li class="page-item"><a class="page-link" href="#">1</a></li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
            <a class="page-link" href="#">Next</a>
          </li>
        </ul>
      </nav>
</body>
</html>